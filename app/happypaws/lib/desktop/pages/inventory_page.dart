import 'dart:async';
import 'dart:convert';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/BaseService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class InventoryPage extends StatefulHookWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  Map<String, dynamic>? products;
  late ScrollController _scrollController;
  late int currentPage = 1;
  bool isLoadingMore = false;
  Map<String, dynamic> params = {'takePhotos': 0};
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    var responseProducts = await ProductsService()
        .getPaged("", currentPage, 10, searchObject: params);
    if (responseProducts.statusCode == 200) {
      setState(() {
        currentPage++;
        if (products == null) {
          products = responseProducts.data;
        } else {
          products!['items'].addAll(responseProducts.data['items']);
        }
      });
    }
  }

  Future<void> updateStock(int id, int newStockValue) async {
    var response =
        await BaseService("Products").put('/$id/$newStockValue', null);
    if (response.statusCode == 200) {
      setState(() {
        final item = products!['items'].firstWhere((x) => x['id'] == id);
        if (item != null) {
          item['inStock'] = newStockValue;
          item['updated'] = true;
        }
        ToastHelper.showToastSuccess(context,
            "You have successfully updates stock value for product with id $id!");
      });
    }
  }

  onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        products = null;
        currentPage = 1;
      });
      fetchProducts();
    });
  }

  Future<void> _scrollListener() async {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double distanceFromBottom = maxScrollExtent - currentPosition;

    if (distanceFromBottom <= 10 &&
        currentPage <= products!['pageCount'] &&
        !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      await fetchProducts();
      setState(() {
        isLoadingMore = false;
      });
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Inventory',
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
                            params['searchParams'] = value;
                          });
                          onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Search by brand, name or UPC...",
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
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                child: table()),
                          ))
                    : const Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 36.0),
                            child: Spinner())),
                if (isLoadingMore)
                  Transform.scale(scale: 0.8, child: const Spinner())
              ],
            ),
          ),
        ));
  }

  dynamic table() {
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
            tableHead('Item name'),
            tableHead('UPC'),
            tableHead('In stock'),
            const TableCell(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Tooltip(
                    message:
                        "If you wish to subtract products just add '-' before number (e.g. '-10').",
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: AppColors.gray,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            tableHead('Actions'),
          ],
        ),
        for (var product in products!['items'])
          TableRow(
            children: [
              tableCell(product['name']),
              tableCell(product['upc']),
              tableCell(product['inStock'].toString(),
                  updated: product['updated'] ?? false),
              TableCell(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  width: 50,
                  child: TextFormField(
                    onChanged: (newValue) {
                      if (int.tryParse(newValue) == null) return;
                      setState(() {
                        product['newStockValue'] =
                            product['inStock'] + int.parse(newValue);
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: const TextStyle(color: AppColors.gray),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.only(
                            bottom: 5, left: 10, right: 10),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 5.0,
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              tableActions(product)
            ],
          ),
      ],
    );
  }

  TableCell tableCell(String data, {bool updated = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
            child: Tooltip(
          message: data.length > 20 ? data : '',
          child: Text(
            data.length > 20 ? '${data.substring(0, 20)}...' : data,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: updated ? AppColors.success : Colors.black),
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
            PrimaryButton(
                onPressed: () => updateStock(data['id'], data['newStockValue']),
                label: "Save")
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
