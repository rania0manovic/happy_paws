import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
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
  List<dynamic>? bestsellers;

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
        await UsersService().getRecommendedProducts();
    if (responseRecommendedProducts.statusCode == 200) {
      setState(() {
        recommendedProducts = responseRecommendedProducts.data;
      });
    }
    var responseBestsellers = await ProductsService().getBestsellers();
    if (responseBestsellers.statusCode == 200) {
      setState(() {
        bestsellers = responseBestsellers.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return categories == null ||
            recommendedProducts == null ||
            bestsellers == null
        ? const Spinner()
        : RefreshIndicator(
          onRefresh: () async {
            await fetchData();
          },
          child: ListView(children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14.0, top: 8),
                      child: GestureDetector(
                          onTap: () =>
                              context.router.push(const OrderHistoryRoute()),
                          child: const Text(
                            'Order history',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                                fontSize: 16),
                          )),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Text(
                        "Categories",
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  categoriesSection(context),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        "Bestsellers",
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  bestsellersSection(),
                  if (recommendedProducts!.isNotEmpty)
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(14),
                            child: Text(
                              "For you",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        forYouSection(),
                      ],
                    ),
                ],
              ),
            ]),
        );
  }

  Container forYouSection() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        top: 0,
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
                      onTap: () => context.router
                          .push(ProductDetailsRoute(productId: product['id'])),
                      child: Image.network(
                        product!['productImages'][0]['image']['downloadURL'],
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
    return Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            for (var product in bestsellers!)
              GestureDetector(
                onTap: () => context.router
                    .push(ProductDetailsRoute(productId: product['id'])),
                child: FractionallySizedBox(
                  widthFactor: 0.45,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                            product!['productImages'][0]['image']
                                ['downloadURL'],
                            height: 140),
                        Text(
                          product['name'].length > 50
                              ? '${product['name'].substring(0, 50)}...'
                              : product['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "\$ ${product['price'].toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ]),
                ),
              ),
          ],
        ));
  }

  Container categoriesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14, right: 14),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Scrollbar(
          thickness: 12,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 10,
              children: [
                if (categories != null)
                  for (var category in categories!['items'])
                    GestureDetector(
                      onTap: () => {
                        context.router.push(ShopCategorySubcategoriesRoute(
                            categoryId: category['id'],
                            categoryName: category['name'],
                            categoryPhoto: category['photo']['downloadURL']))
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.network(
                              category['photo']['downloadURL'],
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
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
