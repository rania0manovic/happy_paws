import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/AppointmentsService.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:intl/intl.dart';

@RoutePage()
class UserAppointmentsPage extends StatefulWidget {
  const UserAppointmentsPage({super.key});

  @override
  State<UserAppointmentsPage> createState() => _UserAppointmentsPageState();
}

class _UserAppointmentsPageState extends State<UserAppointmentsPage> {
  int activeTab = 0;
  Map<String, dynamic>? appointments;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    try {
      var user = await AuthService().getCurrentUser();
      if (user == null) throw Exception('An error has occured.');
      var response = await AppointmentsService()
          .getPaged('', 1, 999, searchObject: {"userId": user['Id']});
      if (response.statusCode == 200) {
        setState(() {
          appointments = response.data;
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateAppointment(dynamic data) async {
    try {
      data['isCancelled'] = true;
      var response = await AppointmentsService().put('', data);
      if (response.statusCode == 200) {
        setState(() {
          appointments!['items'][appointments!['items']
              .indexWhere((x) => x['id'] == data['id'])]['isCancelled'] = true;
          ToastHelper.showToastSuccess(
              context, "You have successfully cancelled the appointment.");
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return appointments == null
        ? const Spinner()
        : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GoBackButton(),
                      const SizedBox(
                        height: 14,
                      ),
                      const Text(
                        "All appointments",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
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
                                for (var appointment in appointments!['items'])
                                  if (appointment['isCancelled'] == false &&
                                      (appointment['startDateTime'] == null ||
                                          DateTime.parse(
                                                  appointment['startDateTime'])
                                              .isAfter(DateTime.now())))
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () => context.router.push(
                                              MakeAppointmentRoute(
                                                  data: appointment)),
                                          child:
                                              appointmentContainer(appointment),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                              ],
                            )
                          : activeTab == 1
                              ? Column(
                                  children: [
                                    for (var appointment
                                        in appointments!['items'])
                                      if (appointment['isCancelled'] == false &&
                                          appointment['startDateTime'] !=
                                              null &&
                                          DateTime.parse(
                                                  appointment['startDateTime'])
                                              .isBefore(DateTime.now()))
                                        Column(
                                          children: [
                                            GestureDetector(
                                                onTap: () => context.router
                                                    .push(MakeAppointmentRoute(
                                                        data: appointment)),
                                                child: appointmentContainer(
                                                    appointment)),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    for (var appointment
                                        in appointments!['items'])
                                      if (appointment['isCancelled'] == true)
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () => context.router.push(
                                                  MakeAppointmentRoute(
                                                      data: appointment)),
                                              child: appointmentContainer(
                                                  appointment),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                  ],
                                ),
                      if (activeTab == 0 &&
                          appointments!['items']
                                  .where((e) =>
                                      e['isCancelled'] == false &&
                                      (e['startDateTime'] == null ||
                                          DateTime.parse(e['startDateTime'])
                                              .isAfter(DateTime.now())))
                                  .length ==
                              0)
                        const Center(
                          child: LightText(
                              label: "You have no upcoming appointments!"),
                        ),
                      if (activeTab == 1 &&
                          appointments!['items']
                                  .where((e) =>
                                      e['isCancelled'] == false &&
                                      (e['startDateTime'] != null &&
                                          DateTime.parse(e['startDateTime'])
                                              .isBefore(DateTime.now())))
                                  .length ==
                              0)
                        const Center(
                          child: LightText(
                              label: "You have no completed appointments!"),
                        ),
                      if (activeTab == 2 &&
                          appointments!['items']
                                  .where((e) => e['isCancelled'] == true)
                                  .length ==
                              0)
                        const Center(
                          child: LightText(
                              label: "You have no cancelled appointments!"),
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
                    ? AppColors.primary
                    : const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "Upcoming",
              style: TextStyle(
                  color: activeTab == 0 ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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
                    ? AppColors.primary
                    : const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "Completed",
              style: TextStyle(
                  color: activeTab == 1 ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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
                    ? AppColors.primary
                    : const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "Cancelled",
              style: TextStyle(
                  color: activeTab == 2 ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )),
          ),
        ),
      ],
    );
  }

  Stack appointmentContainer(dynamic data) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['startDateTime'] == null
                        ? "Date TBA"
                        : DateFormat('EEEE, MMMM dd, yyyy')
                            .format(DateTime.parse(data['startDateTime'])),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    data['startDateTime'] == null
                        ? "Time TBA"
                        : DateFormat("HH:mm")
                            .format(DateTime.parse(data['startDateTime'])),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Pet name:${data['pet']['name']}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: activeTab == 0
                        ? MediaQuery.of(context).size.width * 0.6
                        : double.infinity,
                    child: Text(
                      "Reason:${data['reason'].length > 70 ? '${data['reason'].substring(0, 70)}...' : data['reason']}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ]),
          ),
        ),
        activeTab == 0
            ? Positioned(
                bottom: 10,
                right: 10,
                child: PrimaryButton(
                  label: 'Cancel',
                  backgroundColor: AppColors.error,
                  fontSize: 16,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                          title: 'Confirmation',
                          content:
                              'Are you sure you want to cancel this appointment? This action cannot be undone.',
                          onYesPressed: () {
                            updateAppointment(data);
                            Navigator.of(context).pop();
                          },
                          onNoPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                ))
            : activeTab == 2
                ? const Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text("Cancelled",
                        style: TextStyle(
                            color: AppColors.error,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  )
                : Container()
      ],
    );
  }
}
