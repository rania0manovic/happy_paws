import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

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
                    fontFamily: "GilroyLight",
                    fontWeight: FontWeight.w300),
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
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300,
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
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300,
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
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300,
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
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300,
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
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => {
                    context.router.push(const ShopCategoryOptionsRoute())
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                            image:
                                AssetImage("assets/images/category_cats.png")),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Cats",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                          image: AssetImage("assets/images/category_dogs.png")),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Dogs",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage("assets/images/category_fish.png")),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Fish",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image:
                              AssetImage("assets/images/category_birds.png")),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Birds",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage(
                              "assets/images/category_small_animals.png")),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Small\nanimals",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
