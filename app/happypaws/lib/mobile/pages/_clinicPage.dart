import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class ClinicPage extends StatefulWidget {
  const ClinicPage({super.key});

  @override
  State<ClinicPage> createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upcoming appointments",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    GestureDetector(
                      onTap: () =>
                          {context.router.push(const AppointmentsRoute())},
                      child: const Text(
                        "See all",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'GilroyLight'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    appointmentContainer("Wednesday, March 22 2023", "10:30 AM",
                        "Donna", "Vaccination"),
                    const SizedBox(
                      height: 20,
                    ),
                    appointmentContainer("Sunday, April 23 2023", "02:00 PM",
                        "Ollie", "Neutering"),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const Text(
                  "Medication reminders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 8,
                ),
                medicationContainer(
                    "Vetmedin 5mg", "10:00 AM", "Donna", "After Breakfast"),
                const SizedBox(
                  height: 20,
                ),
                medicationContainer(
                    "Vetmedin 5mg", "10:00 AM", "Donna", "After Breakfast"),
              ],
            ),
          ),
        ),
        addAppointmentButton(context)
      ],
    );
  }

  Positioned addAppointmentButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        right: 20,
        child: GestureDetector(
          onTap: () => context.router.push(const MakeAppointmentRoute()),
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

  Container medicationContainer(
      String medication, String time, String petName, String note) {
    return Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 30),
                  child: Image.asset(
                    "assets/images/pills.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      medication,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/schedule.svg",
                          height: 15,
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            time,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'GilroyLight',
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Pet name: $petName",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'GilroyLight',
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "Note: $note",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'GilroyLight',
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                )
              ],
            )));
  }

  Container appointmentContainer(
      String date, String time, String petName, String reason) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xff3F0D84),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                time,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Pet name: $petName",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'GilroyLight',
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "Reason: $reason",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'GilroyLight',
                    fontWeight: FontWeight.w300),
              )
            ]),
      ),
    );
  }
}
