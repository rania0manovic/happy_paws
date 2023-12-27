import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class RegisterAddPetsPage extends StatefulWidget {
  const RegisterAddPetsPage({super.key});

  @override
  State<RegisterAddPetsPage> createState() => _RegisterAddPetsPageState();
}

class _RegisterAddPetsPageState extends State<RegisterAddPetsPage> {
  bool isAddPet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Center(
                child: Image(
              image: AssetImage("assets/images/cat1.png"),
              height: 180,
              width: 180,
            )),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Happy paws",
                style: TextStyle(
                  fontSize: 35,
                  color: Color(0xff3F0D84),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            !isAddPet
                ? Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 30),
                        child: Text(
                          "Would you like to add your pets right now?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w300,
                              fontFamily: "GilroyLight"),
                        ),
                      ),
                      const Padding(
                          padding:
                              EdgeInsets.only(left: 60, right: 60, top: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 80, right: 80, top: 30),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAddPet = true;
                            });
                          },
                          child: Container(
                            width: 240,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff3F0D84)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 0, left: 20),
                                  child: Text(
                                    "Add",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                      'assets/icons/add.svg',
                                      height: 30,
                                      width: 30,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      GestureDetector(
                        child: Text(
                          "Skip for now.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w300,
                              fontFamily: "GilroyLight"),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 30),
                        child: Text(
                          "Please fill out the form below with correct information to register.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w300,
                              fontFamily: "GilroyLight"),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                inputField('Pet name'),
                                inputField('Pet age'),
                                inputField('Type of pet'),
                                inputField('Breed (optional)'),
                              ],
                            ),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 60, right: 60, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff3F0D84)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(right: 0, left: 20),
                                    child: Text(
                                      "Add another",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                        'assets/icons/add.svg',
                                        height: 30,
                                        width: 30,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {},
                              child: SvgPicture.asset(
                                'assets/icons/long_right_arrow.svg',
                                height: 50,
                                width: 50,
                                color: Color(0xff3F0D84),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          ]),
    ));
  }

  Column inputField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(
              fontFamily: 'GilroyLight',
              fontWeight: FontWeight.w300,
              fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 49,
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff2f2f2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff3F0D84), 
                      width: 5.0, 
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
