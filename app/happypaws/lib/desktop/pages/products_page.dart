import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/desktop/components/api_data_dropdown_menu.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import '../dialogs/add_edit_product_dialog.dart';

@RoutePage()
class ProductsPage extends StatefulHookWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Map<String, dynamic>? products;
  late ScrollController _scrollController;
  late int currentPage = 1;
  bool isLoadingMore = false;
  Map<String, dynamic>? productCategories;
  List<dynamic>? productSubcategories;
  String? selectedCategory;
  String? selectedSubCategory;
  Map<String, dynamic> params = {};
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchData();
  }

  Future<void> fetchProducts() async {
    var responseProducts = await ProductsService()
        .getPaged("", currentPage, 20, searchObject: params);
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

  onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        products = null;
        currentPage=1;
      });
      fetchProducts();
    });
  }

  Future<void> fetchData() async {
    var responseCategories =
        await ProductCategoriesService().getPaged("", 1, 999);
    if (responseCategories.statusCode == 200) {
      setState(() {
        productCategories = responseCategories.data;
      });
    }
  }

  Future<void> fetchSubcategories(String? newValue) async {
    var responseSubcategories =
        await ProductCategorySubcategoriesService().getSubcategories(newValue);
    if (responseSubcategories.statusCode == 200) {
      setState(() {
        productSubcategories = responseSubcategories.data;
      });
    }
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
    useEffect(() {
      fetchProducts();
      return null;
    }, [params['categoryId']]);
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
                      'Product details',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                   
                    SizedBox(
                      width: 250,
                      height:50,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            params['productOrBrandName'] = value;
                          });
                          onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Search by brand or name...",
                            labelStyle: TextStyle(
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
                    if (productCategories != null)
                      SizedBox(
                        width: 200,
                        child: ApiDataDropdownMenu(
                          items: productCategories!['items'],
                          onChanged: (String? newValue) async {
                            // await fetchSubcategories(newValue);
                            setState(() {
                              currentPage = 1;
                              products = null;
                              selectedCategory = newValue;
                              params['categoryId'] = newValue;
                            });
                          },
                          selectedOption: selectedCategory,
                          hint: "Select category...",
                        ),
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditProductMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
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
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                child: table()),
                          ))
                    : const Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 36.0),
                            child: Spinner())),
                if (isLoadingMore) const Spinner()
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
          ),
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
