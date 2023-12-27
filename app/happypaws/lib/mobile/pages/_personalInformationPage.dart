import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';

@RoutePage()
class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  String selectedValue = 'Female';
  late dynamic user = Null;
  late dynamic formatedCardNumber = Null;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    var fetchedUser = await AuthService().getCurrentUser();
    setState(() {
      selectedValue=fetchedUser?['Gender'];
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:  user!=Null ?  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                        alignment: Alignment.topCenter,
                        child:Column(
                          children: [
                            Text("Personal information",
                                style: TextStyle(
                                    fontFamily: 'GilroyLight',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300)),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                height: 128,
                                width: 128,
                                child: Stack(
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            "assets/images/user.png")),
                                    Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Image(
                                            image: AssetImage(
                                                "assets/images/edit.png")))
                                  ],
                                ))
                          ],
                        )),
                    inputField('Name', user["FirstName"]),
                    inputField('Surname', user["LastName"]),
                    inputField('Email', user["Email"]),
                    dropdownMenu("Gender"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Change password",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'GilroyLight',
                            fontSize: 18,
                            fontWeight: FontWeight.w300))
                  ],
                ) : CircularProgressIndicator(),
              )
              ),
        ]),
      ),
    );
  }

  Column dropdownMenu(String label) {
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
        Container(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedValue,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: <String>[
                    'Female',
                    'Male',
                    'Unknown',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              fontFamily: 'GilroyLight',
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                    );
                  }).toList(),
                ),
              ),
            )),
      ],
    );
  }

  Column inputField(String label, String? initialValue) {
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
          child: TextFormField(
            initialValue: initialValue,
            style: const TextStyle(
                fontFamily: 'GilroyLight',
                fontSize: 18,
                fontWeight: FontWeight.w300),
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
