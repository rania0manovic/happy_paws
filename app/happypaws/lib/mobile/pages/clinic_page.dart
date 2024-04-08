import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/AppointmentsService.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/PetMedicationsService.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ClinicPage extends StatefulWidget {
  const ClinicPage({super.key});

  @override
  State<ClinicPage> createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  Map<String, dynamic>? upcomingAppointments;
  Map<String, dynamic>? medicationReminders;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var user = await AuthService().getCurrentUser();
      if (user != null) {
        var appointmentsResponse = await AppointmentsService().getPaged(
            '', 1, 2, searchObject: {
          'userId': user['Id'],
          'minDateTime': DateTime.now()
        });
        var medicationsResponse = await PetMedicationsService().getPaged(
            'endpoint', 1, 999, searchObject: {
          'userId': user['Id'],
          'minDateTime': DateTime.now()
        });
        if (appointmentsResponse.statusCode == 200) {
          setState(() {
            upcomingAppointments = appointmentsResponse.data;
          });
        }
        if (medicationsResponse.statusCode == 200) {
          setState(() {
            medicationReminders = medicationsResponse.data;
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return upcomingAppointments == null || medicationReminders == null
        ? const Spinner()
        : Stack(
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
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.router.push(const UserAppointmentsRoute())
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for (var appointment in upcomingAppointments!['items'])
                        Column(
                          children: [
                            appointmentContainer(
                                appointment['startDateTime'],
                                appointment['pet']['name'],
                                appointment['reason']),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      if (upcomingAppointments!['items'].isEmpty)
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LightText(
                                label: "You have no upcoming appointments!"),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      const Text(
                        "Medication reminders",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      for (var medication in medicationReminders!["items"])
                        Column(
                          children: [
                            medicationContainer(
                                "${medication['medicationName']} ${medication['dosage']} mg",
                                "Every ${medication['dosageFrequency']} hours",
                                medication['pet']['name'],
                                "After Breakfast"),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),

                      // medicationContainer("Vetmedin 5mg", "10:00 AM", "Donna",
                      //     "After Breakfast"),

                      // medicationContainer("Vetmedin 5mg", "10:00 AM", "Donna",
                      //     "After Breakfast"),
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
          onTap: () => context.router.push(MakeAppointmentRoute()),
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
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Pet name: $petName",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Note: $note",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            )));
  }

  Container appointmentContainer(
      String? dateTime, String petName, String reason) {
    return Container(
      height: 180,
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
                dateTime == null
                    ? "Date TBA"
                    : DateFormat('EEEE, MMMM dd, yyyy')
                        .format(DateTime.parse(dateTime)),
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                dateTime == null
                    ? "Time TBA"
                    : DateFormat("HH:mm").format(DateTime.parse(dateTime)),
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Pet name: $petName",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Reason:${reason.length > 70 ? '${reason.substring(0, 70)}...' : reason}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ]),
      ),
    );
  }
}
