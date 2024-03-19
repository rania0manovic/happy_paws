import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/desktop/components/buttons/GoBackButton.dart';
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
  List<Map<String, dynamic>>? userPets;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await PetsService()
        .getPaged('', 1, 999, searchObject: {'userId': widget.userId});
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      setState(() {
        userPets = List<Map<String, dynamic>>.from(jsonData['items']);
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
                            for (var pet in userPets!)
                              GestureDetector(
                                onTap: () => context.router.push(
                                    PetDetailsRoute(userId: widget.userId, petId: pet['id'], onChangedData: fetchData)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 220,
                                      height: 220,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        child: Image.memory(
                                          base64.decode(
                                              pet['photo']['data'].toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      pet['name'],
                                      style: const TextStyle(
                                          color: Color(0xff3F0D84),
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
          onTap: () =>
              context.router.push(PetDetailsRoute(userId: widget.userId, onChangedData: fetchData)),
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
}
