import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/AppointmentsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../dialogs/view_appointment_details_dialog.dart';

@RoutePage()
class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  Map<String, dynamic>? appointments;
  List<dynamic> appointmentsByDate = [];

  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await AppointmentsService().getPaged('', 1, 9999);
    if (response.statusCode == 200) {
      setState(() {
        appointments = response.data;
      });
      filterAppointmentsByDate();
    }
  }

  void filterAppointmentsByDate() {
    if (appointments == null) return;
    var filtered = appointments!['items']!
        .where((appointment) => appointment['startDateTime'] != null)
        .where((appointment) {
      DateTime startDateTime = DateTime.parse(appointment['startDateTime']);
      return startDateTime.year == date.year &&
          startDateTime.month == date.month &&
          startDateTime.day == date.day;
    }).toList();
    setState(() {
      appointmentsByDate = filtered;
    });
  }

  void showAppointmentDetails(
      BuildContext context, Map<String, dynamic> appointment,
      {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 200),
          contentPadding: const EdgeInsets.all(8),
          content: ViewAppointmentDetails(
            appointment: appointment,
            date: date,
            onClose: () {
              Navigator.of(context).pop();
              return fetchData();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (appointments == null) {
      return const Spinner();
    } else {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              height: 50,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "New appointments",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            ListView.builder(
                              controller: ScrollController(),
                              shrinkWrap: true,
                              itemCount: appointments!['totalCount'],
                              itemBuilder: (context, index) {
                                var appointment = appointments!['items'][index];
                                return GestureDetector(
                                  onTap: () {
                                    if (appointment['startDateTime'] == null)
                                      return;
                                    showAppointmentDetails(context, appointment);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: appointment['startDateTime'] == null
                                          ? AppColors.dimWhite
                                          : Colors.transparent,
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.grey.shade300),
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appointment['pet']['owner']['fullName'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy HH:mm').format(
                                            DateTime.parse(
                                                appointment['createdAt']),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Reason: ${appointment['reason']}",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              appointment['startDateTime'] == null
                                                  ? PrimaryButton(
                                                      onPressed: () =>
                                                          showAppointmentDetails(
                                                              context,
                                                              appointment),
                                                      label: "View",
                                                      width: 80,
                                                    )
                                                  : const Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: LightText(
                                                        label:
                                                            "Appointment booked",
                                                        color: AppColors.primary,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ))),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              height: 50,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Scheduled appointments",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            SfDateRangePicker(
                              enablePastDates: false,
                              backgroundColor: Colors.transparent,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              showNavigationArrow: true,
                              selectionColor: AppColors.primary,
                              headerStyle: const DateRangePickerHeaderStyle(
                                  backgroundColor: AppColors.dimWhite,
                                  textAlign: TextAlign.center,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.w700)),
                              todayHighlightColor: AppColors.primary,
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs args) {
                                setState(() {
                                  date = args.value;
                                  filterAppointmentsByDate();
                                });
                              },
                            ),
                            DayView(
                              dayBarStyle: const DayBarStyle(
                                color: AppColors.dimWhite,
                              ),
                              hoursColumnStyle: const HoursColumnStyle(
                                color: AppColors.dimWhite,
                              ),
                              minimumTime: const HourMinute(hour: 8),
                              maximumTime: const HourMinute(hour: 16),
                              inScrollableWidget: true,
                              userZoomable: true,
                              initialTime: const HourMinute(hour: 9),
                              controller: DayViewController(
                                  zoomCoefficient: 2, minZoom: 1, maxZoom: 2),
                              date: date,
                              events: [
                                for (var item in appointmentsByDate)
                                  FlutterWeekViewEvent(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.appointmentColors[
                                              Random().nextInt(AppColors
                                                  .appointmentColors.length)]),
                                      title: item["employee"]["fullName"],
                                      description: item["reason"],
                                      start:
                                          DateTime.parse(item["startDateTime"]),
                                      end: DateTime.parse(item["endDateTime"]),
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                              ],
                              style: const DayViewStyle(
                                  backgroundColor: Colors.white,
                                  currentTimeCircleColor: AppColors.error,
                                  currentTimeRuleColor: AppColors.error,
                                  headerSize: 0),
                            )
                          ],
                        ),
                      ),
                    ))),
          ],
        ),
      );
    }
  }
}
