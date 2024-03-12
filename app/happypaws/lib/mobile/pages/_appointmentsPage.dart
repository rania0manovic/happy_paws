import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserAppointmentsPage extends StatefulWidget {
  const UserAppointmentsPage({super.key});

  @override
  State<UserAppointmentsPage> createState() => _UserAppointmentsPageState();
}

class _UserAppointmentsPageState extends State<UserAppointmentsPage> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(14.0),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              "All appointments",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            tabBar(),
            const SizedBox(
              height: 20,
            ),
            activeTab == 0
                ? Column(
                    children: [
                      appointmentContainer("Wednesday, March 22 2023",
                          "10:30 AM", "Donna", "Vaccination"),
                      const SizedBox(
                        height: 20,
                      ),
                      appointmentContainer("Sunday, April 23 2023", "02:00 PM",
                          "Ollie", "Neutering"),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : activeTab == 1
                    ? Column(
                        children: [
                          appointmentContainer("Wednesday, January 16 2023",
                              "10:30 AM", "Donna", "Check"),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          appointmentContainer("Sunday, March 22 2023",
                              "10:30 AM", "Donna", "Vaccination"),
                          const SizedBox(
                            height: 20,
                          ),
                          appointmentContainer("Monday, June 23 2022",
                              "02:00 PM", "Ollie", "Neutering"),
                          const SizedBox(
                            height: 20,
                          ),
                          appointmentContainer("Friday, April 22 2022",
                              "02:00 PM", "Ollie", "Neutering"),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
          ])),
    );
  }

  Row tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() {
            activeTab = 0;
          }),
          child: Container(
            height: 40,
            width: 104,
            decoration: BoxDecoration(
                color: activeTab == 0
                    ? const Color(0xff3F0D84)
                    : const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "Upcoming",
              style: TextStyle(
                  color: activeTab == 0 ? Colors.white : Colors.black),
            )),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            activeTab = 1;
          }),
          child: Container(
            height: 40,
            width: 104,
            decoration: BoxDecoration(
                color: activeTab == 1
                    ? const Color(0xff3F0D84)
                    : const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "Completed",
              style: TextStyle(
                  color: activeTab == 1 ? Colors.white : Colors.black),
            )),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            activeTab = 2;
          }),
          child: Container(
            height: 40,
            width: 104,
            decoration: BoxDecoration(
                color: activeTab == 2
                    ? const Color(0xff3F0D84)
                    : const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "Cancelled",
              style: TextStyle(
                  color: activeTab == 2 ? Colors.white : Colors.black),
            )),
          ),
        ),
      ],
    );
  }

  Stack appointmentContainer(
      String date, String time, String petName, String reason) {
    return Stack(
      children: [
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              color: activeTab == 2
                  ? const Color.fromARGB(129, 63, 13, 132)
                  : const Color(0xff3F0D84),
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
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Reason: $reason",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ]),
          ),
        ),
        activeTab == 0
            ? Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                      color: const Color(0xffBA1A36),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              )
            : activeTab == 2
                ? const Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text("Cancelled",
                        style: TextStyle(
                          color: Color(0xffBA1A36),
                        )),
                  )
                : Container()
      ],
    );
  }
}
