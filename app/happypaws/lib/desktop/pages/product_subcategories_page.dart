import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
import '../dialogs/add_edit_subcategory_dialog.dart';

@RoutePage()
class SubcategoriesPage extends StatefulWidget {
  const SubcategoriesPage({super.key});

  @override
  State<SubcategoriesPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<SubcategoriesPage> {
  Map<String, dynamic>? productSubcategories;
  Map<String, dynamic> params = {};
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await ProductSubcategoriesService().getPaged("", 1, 999, searchObject: params);
    if (response.statusCode == 200) {
      setState(() {
        productSubcategories = response.data;
      });
    }
  }

  Future<void> deleteSubcategory(int id) async {
    try {
      var response = await ProductSubcategoriesService().delete('/$id');
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully deleted selected subcategory.");
        setState(() {
          productSubcategories!['items'].removeWhere((x) => x['id'] == id);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error occured! Please try again later.");
      rethrow;
    }
  }

  void showAddEditMenu(BuildContext context, {Map<String, dynamic>? data}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(vertical: 80),
            contentPadding: const EdgeInsets.all(8),
            content: AddEditSubcategoryMenu(
              fetchData: fetchData,
              allSubcategories: productSubcategories,
              onClose: () {
                Navigator.of(context).pop();
              },
              data: data,
            ),
          );
        });
  }

  onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        productSubcategories = null;
      });
      fetchData();
    });
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Are you sure you want to delete this subcategory?'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('No'),
            ),
          ],
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
                      'Product subcategories settings',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            params['name'] = value;
                          });
                          onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Search by subcategory name...",
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                            suffixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  size: 25,
                                  color: AppColors.primary,
                                ))),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new subcategory"),
                  ],
                ),
                const SizedBox(height: 16.0),
                if (productSubcategories != null)
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical, child: table()))
                else
                  const Expanded(
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
                header: "Subcategory name",
                alignmentGeometry: Alignment.centerLeft),
            TableHead(header: "Photo", alignmentGeometry: Alignment.center),
            TableHead(
                header: "Actions", alignmentGeometry: Alignment.centerRight),
          ],
        ),
        for (var subcategory in productSubcategories!['items'])
          TableRow(
            children: [
              TableData(
                data: subcategory['name'],
                alignmentGeometry: Alignment.centerLeft,
                paddingHorizontal: 25,
              ),
              TableDataPhoto(data: subcategory['photo']['downloadURL']),
              tableActions(subcategory)
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
                  var response = await ProductsService()
                      .hasAnyWithSubcategoryId(data['id']);
                  if (response.data == true) {
                    if (!mounted) return;
                    ToastHelper.showToastError(context,
                        "You cannot delete this subcategory because it contains one or more products.");
                    return;
                  }
                  if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to delete this product subcategory?',
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deleteSubcategory(data['id']);
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
