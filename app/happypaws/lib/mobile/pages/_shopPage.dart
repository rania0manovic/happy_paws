import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Map<String, dynamic>>? categories;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await ProductCategoriesService().getPaged("", 1, 999);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      setState(() {
        categories = List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Previous orders",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          bestsellersSection(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                "For you",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          forYouSection(),
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
      child: const Scrollbar(
          thickness: 12,
          radius: Radius.circular(10),
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/images/sample_dog_food.jpg"),
                  height: 100,
                  width: 100,
                ),
                Image(
                  image: AssetImage("assets/images/sample_dog_food.jpg"),
                  height: 100,
                  width: 100,
                ),
                Image(
                  image: AssetImage("assets/images/sample_dog_food.jpg"),
                  height: 100,
                  width: 100,
                ),
                Image(
                  image: AssetImage("assets/images/sample_dog_food.jpg"),
                  height: 100,
                  width: 100,
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
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (categories != null)
                  for (var category in categories!)
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
                    child: Spinner())
               
              ],
            ),
          )),
    );
  }
}
