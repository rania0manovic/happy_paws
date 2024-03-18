import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryIconButton.dart';
import 'package:happypaws/desktop/components/buttons/SecondaryButton.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

@RoutePage()
class PetDetailsPage extends StatefulWidget {
  const PetDetailsPage({super.key});

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  String selectedValue = 'Unknown';
  String selectedDate = 'Select date';

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
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
                                    fontSize: 18, fontWeight: FontWeight.w500)),
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
                                            BorderRadius.circular(200),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/pet_default.jpg")),
                                      ),
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
                    inputField('Name:', ""),
                    inputField('Type (e.g. Cat):', ""),
                    inputField('Breed (e.g. British Shorthair):', ""),
                    birthDateInput(context),
                    dropdownMenu("Gender:"),
                    allergiesSection(),
                    medicationSection(),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  Column birthDateInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Date of birth (approximately):',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        PrimaryIconButton(
          icon: const Icon(
            Icons.date_range_rounded,
            color: Colors.white,
          ),
          label: selectedDate,
          width: double.infinity,
          onPressed: () {
            _showDatePicker(context);
          },
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context)
                .size
                .width, // Adjust the height as needed
            child: SfDateRangePicker(
              maxDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                final formatter = DateFormat('dd.MM.yyyy'); // Define the format
                setState(() {
                  selectedDate =
                      formatter.format(args.value!); // Format the date
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
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
          "Medications:",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
          "Allergies:",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
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
                    'Unknown',
                    'Female',
                    'Male',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
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
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 49,
          child: TextFormField(
            initialValue: initialValue,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
