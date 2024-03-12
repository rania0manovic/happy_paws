import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class MyPetsPage extends StatefulWidget {
  const MyPetsPage({super.key});

  @override
  State<MyPetsPage> createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
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
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "My pets",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () => context.router.push(const PetDetailsRoute()),
                              child: petContainer(
                                  "assets/images/mypet-dog.jpg", "Donna")),
                          petContainer("assets/images/mypet-cat.jpg", "Ollie")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      addNewPet(context)]
    );
  }
Positioned addNewPet(BuildContext context) {
    return Positioned(
        bottom: 15,
        right: 15,
        child: GestureDetector(
          child: Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xff3F0D84)),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(
                "assets/icons/add.svg",
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
  Column petContainer(String url, String petName) {
    return Column(
      children: [
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              image:
                  DecorationImage(image: AssetImage(url), fit: BoxFit.cover)),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          petName,
          style: const TextStyle(
              color: Color(0xff3F0D84),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
