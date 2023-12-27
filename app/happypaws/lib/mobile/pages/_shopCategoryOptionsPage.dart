import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ShopCategoryOptionsPage extends StatelessWidget {
  const ShopCategoryOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [petCategoriesHeader(context), petCategoriesSection()],
      ),
    );
  }

  Padding petCategoriesHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.router.pop(),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 14.0),
              child: Text(
                'Go back',
                style: TextStyle(
                    fontFamily: 'GilroyLight',
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
              ),
            ),
          ),
          const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image(
              image: AssetImage("assets/images/category_cats.png"),
              width: 55,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Cats",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Padding petCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 40,
        runSpacing: 20,
        children: [
          Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/food.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Food",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: "GilroyLight"),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/beds.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Beds",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: "GilroyLight"),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/medicine.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Medicine",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: "GilroyLight"),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/toys.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Toys",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: "GilroyLight"),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/hygine.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Hygiene",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: "GilroyLight"),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/cariges.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Carriers",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      fontFamily: "GilroyLight"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
