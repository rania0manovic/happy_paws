import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MakeAppointmentPage extends StatefulWidget {
  const MakeAppointmentPage({super.key});

  @override
  State<MakeAppointmentPage> createState() => _MakeAppointmentPageState();
}

class _MakeAppointmentPageState extends State<MakeAppointmentPage> {
  String selectedValue = 'Donna';
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
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          ),
          const Text(
            "Make an appointment",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Please pick your pet:',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          dropdownMenu(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Please describe your reason for visit:',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.only(top: 6),
          height: 200,
          child: TextField(
            minLines: 10,
            maxLines: 10,
            style: const TextStyle( fontWeight: FontWeight.w500, fontSize: 14),
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
        ),
         const SizedBox(
            height: 20,
          ),
          const Text(
            'Note (optional):',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.only(top: 6),
          height: 150,
          child: TextField(
            minLines: 5,
            maxLines: 5,
            style: const TextStyle( fontWeight: FontWeight.w500, fontSize: 14),
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
        ),
        GestureDetector(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff3F0D84)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 0, left: 0),
                                child: Text(
                                  "Make",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
        ]),
      ),
    );
  }

  Container dropdownMenu() {
    return Container(
        padding: const EdgeInsets.only(top: 6),
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
                'Donna',
                'Ollie',
                'Mark',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
