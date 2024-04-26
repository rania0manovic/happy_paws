import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/services/UserCartsService.dart';
import 'package:happypaws/common/services/UserFavouritesService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage(
      {super.key, @PathParam('id') required this.productId});

  final int productId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Map<String, dynamic>? product;
  int selectedImageId = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await ProductsService().get('/${widget.productId}');
    if (response.statusCode == 200) {
      setState(() {
        product = response.data;
      });
    }
  }

  Future<void> addProductToCart() async {
    var productAlreadyInCart = await UserCartsService()
        .get("/ProductAlreadyInCart?productId=${widget.productId}");
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
    var data = {'userId': userId, 'productId': widget.productId};
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

  Future<void> removeProductFromFavourites() async {
    try {
      var response = await UserFavouritesService()
          .delete('/${product!['userFavouriteItems'][0]['id']}');
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "Successfully removed product from favourites!");
        setState(() {
          product!["isFavourite"] = false;
        });
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

  Future<void> addProductToFavourites() async {
    var fetchedUser = await AuthService().getCurrentUser();
    var userId = fetchedUser?['Id'];
    var data = {'userId': userId, 'productId': widget.productId};
    try {
      var response = await UserFavouritesService().post('', data);
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "Successfully added product to favourites!");
        setState(() {
          product!['userFavouriteItems'].add(response.data);
          product!["isFavourite"] = true;
        });
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
    if (product == null) {
      return const Spinner();
    } else {
      return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(left: 14.0),
            child: GoBackButton(),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: picturesSection()),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
            child: Text(
              product!['name'],
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$ ${product!['price']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 24),
                ),
                if (product!['review'] == 0)
                  const Text('No reviews yet')
                else
                  Row(
                    children: List.generate(5, (index) {
                      if (index < product!['review']) {
                        return const Image(
                          image: AssetImage("assets/images/star.png"),
                          height: 25,
                          width: 25,
                        );
                      } else {
                        return const Opacity(
                          opacity: 0.5,
                          child: Image(
                            image: AssetImage("assets/images/star-empty.png"),
                            height: 25,
                            width: 25,
                          ),
                        );
                      }
                    }),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Description(
                title: "Description", content: product!['description']),
          ),
          actionsSection()
        ]),
      );
    }
  }

  Padding actionsSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 34, right: 34, top: 20, bottom: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: [
            GestureDetector(
                onTap: () => addProductToCart(),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: PrimaryIconButton(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    label: "Add to cart",
                    fontSize: 18,
                    width: double.infinity,
                    onPressed: () {
                      addProductToCart();
                    },
                  ),
                )),
            GestureDetector(
              onTap: () => product!['isFavourite']
                  ? removeProductFromFavourites()
                  : addProductToFavourites(),
              child: Container(
                  height: 48,
                  width: 48,
                  padding: const EdgeInsets.all(0),
                  child: Icon(
                    product!['isFavourite']
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 35,
                    color: AppColors.primary,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Column picturesSection() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Image.memory(
                base64.decode(product!['productImages'][selectedImageId]
                    ['image']['data']),
                height: 250)),
        Padding(
          padding:
              const EdgeInsets.only(left: 34, right: 34, top: 10, bottom: 10),
          child: Scrollbar(
              thickness: 12,
              radius: const Radius.circular(10),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < product!['productImages'].length; i++)
                      GestureDetector(
                        onTap: () => setState(() {
                          selectedImageId = i;
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selectedImageId == i
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: Image.memory(
                            base64.decode(
                                product!['productImages'][i]['image']['data']),
                            height: 47,
                            width: 47,
                          ),
                        ),
                      ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

class Description extends StatefulWidget {
  final String title;
  final String content;

  const Description({super.key, required this.title, required this.content});
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
          top: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  widget.content,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
