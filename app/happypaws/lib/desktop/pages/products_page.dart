import 'dart:convert';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import '../dialogs/add_edit_product_dialog.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Map<String, dynamic>? products;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var responseProducts = await ProductsService().getPaged("", 1, 999);
    if (responseProducts.statusCode == 200) {
      setState(() {
        products = responseProducts.data;
      });
    }
  }

  void showAddEditProductMenu(BuildContext context,
      {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 100, horizontal: 200),
          contentPadding: const EdgeInsets.all(8),
          content: AddEditProductMenu(
            data: data,
            fetchData: fetchData,
            onClose: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Future<void> deleteProduct(int id) async {
    try {
      var response = await ProductsService().delete('/$id');
      if (response.statusCode == 200) {
        fetchData();
      }
    } catch (e) {
      rethrow;
    }
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
                      'Product details',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditProductMenu(context),
                        icon: const Icon(Icons.add, color: Colors.white,),
                        label: "Add new product"),
                  ],
                ),
                const SizedBox(height: 16.0),
                products != null
                    ? (products!.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Text(
                              'No products added yet.',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ))
                        : Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical, child: table()),
                          ))
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
            tableHead('Item Id.'),
            tableHead('Photo'),
            tableHead('Item name'),
            tableHead('Item category'),
            tableHead('Item subcategory'),
            tableHead('Inventory'),
            tableHead('Actions'),
          ],
        ),
        for (var product in products!['items'])
          TableRow(
            children: [
              tableCell(product['id'].toString()),
              tableCellPhoto(product['productImages'][0]['image']['data']),
              tableCell(product['name']),
              tableCell(product['productCategorySubcategory']['productCategory']
                  ['name']),
              tableCell(product['productCategorySubcategory']
                  ['productSubcategory']['name']),
              tableCell(product['inStock'].toString()),
              tableActions(product)
            ],
          )
      ],
    );
  }

  TableCell tableCell(String data) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
            child: Tooltip(
          message: data.length > 20 ? data : '',
          child: Text(
            data.length > 20 ? '${data.substring(0, 20)}...' : data,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )),
      ),
    );
  }

  TableCell tableCellPhoto(String data) {
    return TableCell(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0.0),
            child: Image.memory(
              base64.decode(data.toString()),
              height: 30,
            )));
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              onPressed: () {
                showAddEditProductMenu(context, data: data);
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
                      content: 'Are you sure you want to delete this product?',
                      onYesPressed: () {
                        Navigator.of(context).pop();
                        deleteProduct(data['id']);
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
    );
  }

  TableCell tableHead(String header) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            header,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
