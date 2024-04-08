import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Map<String, dynamic>? categories;
  List<dynamic>? recommendedProducts;

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
        categories = responseCategories.data;
      });
    }
    var responseRecommendedProducts =
        await ProductsService().getRecommendedProductsForUser();
    if (responseRecommendedProducts.statusCode == 200) {
      setState(() {
        recommendedProducts = responseRecommendedProducts.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return categories == null || recommendedProducts == null
        ? const Spinner()
        : SingleChildScrollView(
            child: Column(
              children: [
                // const Align(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: EdgeInsets.all(10),
                //     child: Text(
                //       "Previous orders",
                //       style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w500),
                //     ),
                //   ),
                // ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                categoriesSection(context),
                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: EdgeInsets.all(14),
                //     child: Text(
                //       "Bestsellers",
                //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                //     ),
                //   ),
                // ),
                // bestsellersSection(),
                if(recommendedProducts!.isNotEmpty)
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          "For you",
                          style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    forYouSection(),
                  ],
                ),
              ],
            ),
          );
  }

  Container forYouSection() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 14,
      ),
      child: Scrollbar(
          thickness: 12,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var product in recommendedProducts!)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => context.router.push(ProductDetailsRoute(productId: product['id'])),
                      child: Image.memory(
                        base64.decode(product!['productImages'][0]['image']['data']
                            .toString()),
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
              ],
            ),
          )),
    );
  }

  Padding bestsellersSection() {
    return const Padding(
        padding: EdgeInsets.all(14),
        child: Wrap(
          spacing: 20,
          children: [
            SizedBox(
              height: 200,
              width: 160,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                        image: AssetImage(
                          "assets/images/sample_dog_food.jpg",
                        ),
                        height: 140),
                    Text(
                      "MaroSnacks",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\$ 19.97",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 200,
              width: 160,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                        image: AssetImage(
                          "assets/images/sample_dog_food.jpg",
                        ),
                        height: 140),
                    Text(
                      "MaroSnacks",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\$ 19.97",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 200,
              width: 160,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                        image: AssetImage(
                          "assets/images/sample_dog_food.jpg",
                        ),
                        height: 140),
                    Text(
                      "MaroSnacks",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\$ 19.97",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 200,
              width: 160,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                        image: AssetImage(
                          "assets/images/sample_dog_food.jpg",
                        ),
                        height: 140),
                    Text(
                      "MaroSnacks",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\$ 19.97",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }

  Container categoriesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 14,
      ),
      color: const Color(0xffFAFAFC),
      child: Scrollbar(
          thickness: 12,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (categories != null)
                  for (var category in categories!['items'])
                    GestureDetector(
                      onTap: () => {
                        context.router.push(ShopCategorySubcategoriesRoute(
                            categoryId: category['id'],
                            categoryName: category['name'],
                            categoryPhoto: category['photo']['data']))
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.memory(
                              base64
                                  .decode(category['photo']['data'].toString()),
                              height: 128,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category['name'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                else
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      child: const Spinner())
              ],
            ),
          )),
    );
  }
}