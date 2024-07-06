import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/services/UserCartsService.dart';
import 'package:happypaws/common/services/UserFavouritesService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

import 'filter_menu_overlay.dart';

@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage(
      {super.key,
      @PathParam('categoryId') this.categoryId,
      @PathParam('subcategoryId') this.subcategoryId,
      this.categoryPhoto,
      this.categoryName,
      this.subcategoryName,
      this.searchInput,
      this.isShowingFavourites});

  final int? categoryId;
  final int? subcategoryId;
  final String? categoryPhoto;
  final String? categoryName;
  final String? subcategoryName;
  final String? searchInput;
  final bool? isShowingFavourites;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late int currentPage = 1;
  bool isLoadingMore = false;
  late String selectedValuePrice = "none";
  late String selectedValueReview = "0";
  Map<String, dynamic>? products;
  Map<String, dynamic> params = {};
  late ScrollController _scrollController;
  late ScrollController _scrollControllerGrid;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollControllerGrid = ScrollController();
    _scrollController.addListener(_scrollListener);
    if (widget.isShowingFavourites == null) {
      setState(() {
        params['categoryId'] = widget.categoryId?.toString();
        params['subcategoryId'] = widget.subcategoryId?.toString();
        params['onlyActive'] = true;
        params['searchParams'] = widget.searchInput;
      });
    }
    fetchData();
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
      await fetchData();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> fetchData() async {
    dynamic response;
    if (widget.isShowingFavourites != null && widget.isShowingFavourites!) {
      var fetchedUser = await AuthService().getCurrentUser();
      if (fetchedUser != null) {
        setState(() {
          params['userId'] = fetchedUser["Id"];
          params['pageNumber'] = currentPage;
          params['pageSize'] = 10;
        });
      }
      response = await UserFavouritesService().getPagedProducts(params);
    } else {
      response = await ProductsService()
          .getPaged('', currentPage, 10, searchObject: params);
    }
    if (response.statusCode == 200) {
      setState(() {
        currentPage++;
        if (products == null) {
          products = response.data;
        } else {
          products!['items'].addAll(response.data['items']);
        }
      });
    }
  }

  void sortData() {
    if (selectedValuePrice != "none" || selectedValueReview != '0') {
      setState(() {
        currentPage = 1;
        params['lowestPriceFirst'] = selectedValuePrice == 'lowest'
            ? true
            : selectedValuePrice == 'highest'
                ? false
                : null;
        params['minReview'] =
            selectedValueReview != '0' ? selectedValueReview : null;
        products = null;
        fetchData();
      });
    }
  }

  void resetFilters() {
    setState(() {
      products = null;
      selectedValuePrice = 'none';
      selectedValueReview = '0';
      params['lowestPriceFirst'] = null;
      params['minReview'] = null;
      currentPage = 1;
      fetchData();
    });
  }

  Future<void> addProductToCart(int id) async {
    var productAlreadyInCart =
        await UserCartsService().get("/ProductAlreadyInCart?productId=$id");
    if (productAlreadyInCart.statusCode != 200) {
      throw Exception();
    }
    if (productAlreadyInCart.data) {
      if (!mounted) return;
      ToastHelper.showToastWarning(context,
          "Product is already in cart! To increase the quantity please go to cart.");
      return;
    }

    var fetchedUser = await AuthService().getCurrentUser();
    var userId = fetchedUser?['Id'];
    var data = {'userId': userId, 'productId': id};
    try {
      var response = await UserCartsService().post('', data);
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "Successfully added product into the cart!");
      } else {
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "Something went wrong! Please try again.");
      }
    } catch (e) {
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      return const Spinner();
    } else {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const GoBackButton(),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterMenu(context);
                      },
                      color: (selectedValuePrice != "none" ||
                              selectedValueReview != '0')
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                    if ((selectedValuePrice != "none" ||
                        selectedValueReview != '0'))
                      GestureDetector(
                          onTap: () => resetFilters(),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.error,
                          )),
                  ],
                ),
                if (widget.categoryName != null && widget.categoryPhoto != null)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: header(context)),
                if (products != null)
                  if (products!['items'].isNotEmpty)
                    productsSection()
                  else
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Text(
                          widget.isShowingFavourites != null
                              ? "You don't have any favourites ˙◠˙"
                              : "We found no active products ˙◠˙",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                if (products!['items'].length <= 4)
                  const SizedBox(
                    height: 100,
                  )
              ]),
        ),
      );
    }
  }

  void _showFilterMenu(BuildContext context) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: FilterMenuOverlay(
          sort: (price, review) {
            setState(() {
              selectedValuePrice = price;
              selectedValueReview = review;
            });
            sortData();
            overlayEntry.remove();
          },
          selectedValuePrice: selectedValuePrice,
          selectedValueReview: selectedValueReview,
          onClose: () {
            overlayEntry.remove();
          },
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

  dynamic productsSection() {
    return GridView.builder(
      controller: _scrollControllerGrid,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 200),
      itemCount: products!['items'].length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < products!['items'].length) {
          final item = products!['items'][index];
          return GestureDetector(
            onTap: () =>
                context.router.push(ProductDetailsRoute(productId: item['id'])),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        item['productImages'][0]['image']['downloadURL'],
                        height: 110,
                      ),
                      Text(
                        item['name'].length > 40
                            ? '${item['name'].substring(0, 40)}...'
                            : item['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '\$ ${item['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          if (item!['review'] == 0)
                            const Text(
                              'No reviews ',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.gray),
                            )
                          else
                            Row(
                              children: List.generate(5, (index) {
                                if (index < item['review']) {
                                  return const Image(
                                    image: AssetImage("assets/images/star.png"),
                                    height: 14,
                                    width: 14,
                                  );
                                } else {
                                  return const Opacity(
                                    opacity: 0.5,
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/star-empty.png"),
                                      height: 14,
                                      width: 14,
                                    ),
                                  );
                                }
                              }),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryMediumLight),
                        onPressed: () {
                          addProductToCart(item['id']);
                        },
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          );
        } else if (isLoadingMore) {
          return const Center(child: Spinner());
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Row header(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      ClipOval(
          child: Image.network(
        widget.categoryPhoto!,
        height: 55,
        fit: BoxFit.cover,
      )),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          widget.categoryName!,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text(
          " / ${widget.subcategoryName}",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    ]);
  }
}
