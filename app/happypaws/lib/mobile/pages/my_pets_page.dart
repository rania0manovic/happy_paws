import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class MyPetsPage extends StatefulWidget {
  const MyPetsPage({super.key, required this.userId});
  final String userId;

  @override
  State<MyPetsPage> createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  Map<String, dynamic>? userPets;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await PetsService()
        .getPaged('', 1, 999, searchObject: {'userId': widget.userId});
    if (response.statusCode == 200) {
      setState(() {
        userPets = response.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userPets == null) {
      return const Spinner();
    } else {
      return Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GoBackButton(),
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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (userPets!['totalCount'] == 0)
                              const Text(
                                "You have not added any pets yet.",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            for (var pet in userPets!['items'])
                              GestureDetector(
                                onTap: () => context.router.push(
                                    PetDetailsRoute(
                                        userId: widget.userId,
                                        petId: pet['id'],
                                        onChangedData: fetchData)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 220,
                                      height: 220,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        child: pet['photo']!=null ? Image.network(
                                         pet['photo']['downloadURL'],
                                          fit: BoxFit.cover,
                                        ) : const Image(
                              image: AssetImage("assets/images/pet_default.jpg"),)
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      pet['name'],
                                      style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              )
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
        addNewPet(context)
      ]);
    }
  }

  Positioned addNewPet(BuildContext context) {
    return Positioned(
        bottom: 15,
        right: 15,
        child: GestureDetector(
          onTap: () => context.router.push(
              PetDetailsRoute(userId: widget.userId, onChangedData: fetchData)),
          child: Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.primary),
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
}
