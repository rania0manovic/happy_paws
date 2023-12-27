import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PetDetailsPage extends StatefulWidget {
  const PetDetailsPage({super.key});

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  String selectedValue = 'Female';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            const Text("Pet information",
                                style: TextStyle(
                                    fontFamily: 'GilroyLight',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300)),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                height: 128,
                                width: 128,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/mypet-dog.jpg"))),
                                    ),
                                    const Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Image(
                                            image: AssetImage(
                                                "assets/images/edit.png")))
                                  ],
                                ))
                          ],
                        )),
                    inputField('Name:', "Donna"),
                    inputField('Breed:', "American Staffordshire Terrier"),
                    inputField('Age:', "7"),
                    dropdownMenu("Gender:"),
                    allergiesSection(),
                    medicationSection(),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  Column medicationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Medications",
          style: TextStyle(
              fontFamily: 'GilroyLight',
              fontWeight: FontWeight.w300,
              fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 18.0, 
            runSpacing: 8.0, 
            children: [listItem("Vetmedin 5mg")],
          ),
        ),
      ],
    );
  }
  

  Column allergiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Allergies",
          style: TextStyle(
              fontFamily: 'GilroyLight',
              fontWeight: FontWeight.w300,
              fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 18.0, 
            runSpacing: 8.0, 
            children: [listItem("Soy"), listItem("Eggs")],
          ),
        ),
      ],
    );
  }

  Wrap listItem(String allergy) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 8.0,
          color: Colors.grey.shade400,
        ),
        const SizedBox(width: 8.0), 
        Text(
          allergy,
          style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'GilroyLight',
              fontWeight: FontWeight.w300), 
        ),
      ],
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
                    'Other',
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
