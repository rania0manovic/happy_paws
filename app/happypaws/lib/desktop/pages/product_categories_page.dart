import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/common/services/ProductSubcategoriesService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/dialogs/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import '../dialogs/add_edit_category_dialog.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<CategoriesPage> {
  List<Map<String, dynamic>>? productCategories;
  List<Map<String, dynamic>>? productSubcategories;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var responseCategories =
        await ProductCategoriesService().getPaged("", 1, 999);
    if (responseCategories.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseCategories.body);
      setState(() {
        productCategories = List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
    var responseSubcategories =
        await ProductSubcategoriesService().getPaged("", 1, 999);
    if (responseSubcategories.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseSubcategories.body);
      setState(() {
        productSubcategories =
            List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
  }

  Future<void> 
  deleteCategory(int id) async {
    try {
      var response = await ProductCategoriesService().delete('/$id');
      if (response.statusCode == 200) {
        fetchData();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>?> fetchSubcategoryIds(Map<String, dynamic> data) async {
    int categoryId = data['id'];
    var response = await ProductCategorySubcategoriesService()
        .getSubcategoryIds(categoryId);

    if (response.statusCode == 200) {
      return json.decode(response.body).cast<int>();
    } else {
      return null;
    }
  }

  Future<void> showAddEditMenu(BuildContext context,
      {Map<String, dynamic>? data}) async {
    List<int>? listIds;

    if (data != null) {
      await fetchSubcategoryIds(data).then((result) {
        listIds = result;
      });
    }
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: AddEditCategoryOverlay(
            onClose: () {
              Navigator.of(context).pop();
            },
            fetchData: fetchData,
            data: data,
            subcategories: productSubcategories,
            listIds: listIds,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories settings',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(Icons.add, color: Colors.white,),
                        label: "Add new category"),
                  ],
                ),
                const SizedBox(height: 16.0),
                productCategories != null
                    ? table()
                    : const Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 36.0),
                            child: Spinner()))
              ],
            ),
          ),
        ));
  }

  Table table() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        horizontalInside: BorderSide(
          color: AppColors.gray.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: tableHead('Category name'),
            ),
            Align(alignment: Alignment.center, child: tableHead('Photo')),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: tableHead('Actions'),
                )),
          ],
        ),
        for (var category in productCategories!)
          TableRow(
            children: [
              tableCell(category['name']),
              tableCellPhoto(category['photo']['data']),
              tableActions(category)
            ],
          ),
      ],
    );
  }

  TableCell tableCell(String data) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30),
        child: Text(
          data,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  TableCell tableCellPhoto(String data) {
    return TableCell(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0.0),
            child: Image.memory(
              base64.decode(data.toString()),
              height: 25,
            )));
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                onPressed: () {
                  showAddEditMenu(context, data: data);
                },
                icon: Icons.edit_outlined,
                iconColor: AppColors.gray,
              ),
              ActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to delete this product category?',
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deleteCategory(data['id']);
                        },
                        onNoPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                icon: Icons.delete_outline_outlined,
                iconColor: AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableCell tableHead(String header) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(
          header,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
