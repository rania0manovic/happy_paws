import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/common/services/ProductSubcategoriesService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/components/table/table_data.dart';
import 'package:happypaws/desktop/components/table/table_data_photo.dart';
import 'package:happypaws/desktop/components/table/table_head.dart';
import '../dialogs/add_edit_category_dialog.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<CategoriesPage> {
  Map<String, dynamic>? productCategories;
  Map<String, dynamic>? productSubcategories;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var responseCategories =
        await ProductCategoriesService().getPaged("", 1, 999);
    if (responseCategories.statusCode == 200) {
      setState(() {
        productCategories = responseCategories.data;
      });
    }
    var responseSubcategories =
        await ProductSubcategoriesService().getPaged("", 1, 999);
    if (responseSubcategories.statusCode == 200) {
      setState(() {
        productSubcategories = responseSubcategories.data;
      });
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      var response = await ProductCategoriesService().delete('/$id');
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully deleted selected category.");
        setState(() {
          productCategories!['items'].removeWhere((x) => x['id'] == id);
        });
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
      return response.data.cast<int>();
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
            allCategories: productCategories,
            subcategories: productSubcategories!,
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
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new category"),
                  ],
                ),
                const SizedBox(height: 16.0),
                productCategories != null && productSubcategories != null
                    ? Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical, child: table()))
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
          children: const [
            TableHead(
                header: "Category name",
                alignmentGeometry: Alignment.centerLeft),
            TableHead(header: "Photo", alignmentGeometry: Alignment.center),
            TableHead(
                header: "Actions", alignmentGeometry: Alignment.centerRight),
          ],
        ),
        for (var category in productCategories!['items'])
          TableRow(
            children: [
              TableData(
                data: category['name'],
                alignmentGeometry: Alignment.centerLeft,
                paddingHorizontal: 25,
              ),
              TableDataPhoto(data: category['photo']['data']),
              tableActions(category)
            ],
          ),
      ],
    );
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
                onPressed: () async {
                  var response =
                      await ProductsService().hasAnyWithCategoryId(data['id']);
                  if (response.data == true) {
                    if (!mounted) return;
                    ToastHelper.showToastError(context,
                        "You cannot delete this category because it contains one or more products.");
                    return;
                  }
                  if (!mounted) return;
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
}
