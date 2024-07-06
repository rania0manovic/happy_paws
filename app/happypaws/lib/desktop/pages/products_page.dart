import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:happypaws/common/services/OrdersService.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/api_data_dropdown_menu.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/components/table/table_data.dart';
import 'package:happypaws/desktop/components/table/table_data_photo.dart';
import 'package:happypaws/desktop/components/table/table_head.dart';
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
  Map<String, dynamic> params = { 'getReviews':false};
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    var responseProducts = await ProductsService()
        .getPaged("", currentPage, 15, searchObject: params);
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
        currentPage = 1;
      });
      fetchProducts();
    });
  }

  Future<void> fetchCategories() async {
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
          insetPadding: const EdgeInsets.symmetric(horizontal: 200),
          contentPadding: const EdgeInsets.all(8),
          content: AddEditProductMenu(
            data: data,
            onClose: () {
              Navigator.of(context).pop();
            },
            onEdit: (value) {
              setState(() {
                products!['items'][products!['items']
                    .indexWhere((x) => x['id'] == value['id'])] = value;
              });
            },
            onAdd: (value) {
              if (products!['hasNextPage']) return;
              setState(() {
                products!['items'].add(value);
              });
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
        setState(() {
          products!['items'].removeWhere((x) => x['id'] == id);
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully deleted selected product!");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deactivateProduct(data) async {
    try {
      var response = await ProductsService().updateActivityStatus(
          {'id': data['id'], 'isActive': !data['isActive']});
      if (response.statusCode == 200) {
        setState(() {
          products!['items']
                  .firstWhere((x) => x['id'] == data['id'])['isActive'] =
              !data['isActive'];
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully ${!data['isActive'] == false ? "activated" : " deactivated"} selected product!");
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
                    if (productCategories != null)
                      SizedBox(
                        width: 200,
                        child: ApiDataDropdownMenu(
                          items: productCategories!['items'],
                          onChanged: (String? newValue) async {
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
                    if (params["categoryId"] != null &&
                        params["categoryId"] != 0)
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                currentPage = 1;
                                selectedCategory = null;
                                products = null;
                                params["categoryId"] = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 24,
                              color: AppColors.error,
                            ),
                          ))
                    else
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
          children: const [
            TableHead(
              header: "Id.",
              alignmentGeometry: Alignment.center,
            ),
            TableHead(header: "Photo", alignmentGeometry: Alignment.center),
            TableHead(header: "Name", alignmentGeometry: Alignment.center),
            TableHead(header: "Category", alignmentGeometry: Alignment.center),
            TableHead(
                header: "Subcategory", alignmentGeometry: Alignment.center),
            TableHead(header: "UPC", alignmentGeometry: Alignment.center),
            TableHead(header: "Actions", alignmentGeometry: Alignment.center),
          ],
        ),
        for (var product in products!['items'])
          TableRow(
            children: [
              TableData(
                data: product['id'].toString(),
              ),
              TableDataPhoto(
                  borderRadius: 0,
                  size: 30,
                  data: product['productImages'][0]['image']['downloadURL']),
              TableData(
                data: product['name'],
              ),
              TableData(
                data: product['productCategorySubcategory']['productCategory']
                    ['name'],
              ),
              TableData(
                data: product['productCategorySubcategory']
                    ['productSubcategory']['name'],
              ),
              TableData(data: product['upc']),
              tableActions(product),
            ],
          ),
      ],
    );
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'Edit',
              child: ActionButton(
                onPressed: () {
                  showAddEditProductMenu(context, data: data);
                },
                icon: Icons.edit_outlined,
                iconColor: AppColors.gray,
              ),
            ),
            Tooltip(
              message: data['isActive'] ? "Deactivate" : "Activate",
              child: ActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        title: 'Confirmation',
                        content: data['isActive']
                            ? 'Are you sure you want to deactivate this product? Deactivated product will be removed from shop for purchase. If you wish you can activate it again later.'
                            : "Are you sure you want to activate this product? Active products are avaliable in shop for purchase.",
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deactivateProduct(data);
                        },
                        onNoPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                icon: Icons.disabled_visible_outlined,
                iconColor:
                    data['isActive'] ? AppColors.error : AppColors.success,
              ),
            ),
            Tooltip(
              message: 'Delete',
              child: ActionButton(
                onPressed: () async {
                  var response =
                      await OrdersService().hasAnyByProductId(data['id']);
                  if (response.data == true) {
                    if (!mounted) return;
                    ToastHelper.showToastError(context,
                        "This product cannot be deleted as it has already been included in previous orders. You may deactivate the product if you wish to remove it from availability.");
                    return;
                  }
                  if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to delete this product?',
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
            ),
          ],
        ),
      ),
    );
  }
}
