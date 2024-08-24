import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/AppointmentsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/Toast.dart';
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
  Map<String, dynamic> params = {'isCancelled': false};
  List<dynamic> appointmentsByDate = [];
  bool newFirst = true;
  DateTime date = DateTime.now();
  bool showNewOnly = false;
  final formatter = DateFormat('dd.MM.yyyy');
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchAppointments();
    filterAppointmentsByDate();
  }

  Future<void> fetchAppointments() async {
    try {
      var response = await AppointmentsService()
          .getPaged('', 1, 9999, searchObject: params);
      if (response.statusCode == 200) {
        setState(() {
          appointments = response.data;
        });
      }
    } on DioException catch (e) {
      if (!mounted) return;
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      } else {
        ToastHelper.showToastError(
            context, "An error has occured! Please try again later.");
      }
      rethrow;
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

  void sortData() {
    setState(() {
      if (newFirst) {
        appointments!['items'].sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));
      } else {
        appointments!['items'].sort((a, b) => DateTime.parse(a['createdAt'])
            .compareTo(DateTime.parse(b['createdAt'])));
      }
    });
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
                child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.transparent,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Appointments history",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            var params = {};

                                            return AlertDialog(
                                              content: SizedBox(
                                                height: 300,
                                                width: 300,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 250,
                                                      child: SfDateRangePicker(
                                                        enablePastDates: true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        selectionMode:
                                                            DateRangePickerSelectionMode
                                                                .range,
                                                        showNavigationArrow:
                                                            true,
                                                        selectionColor:
                                                            AppColors.primary,
                                                        headerStyle: const DateRangePickerHeaderStyle(
                                                            backgroundColor:
                                                                AppColors
                                                                    .dimWhite,
                                                            textAlign: TextAlign
                                                                .center,
                                                            textStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        todayHighlightColor:
                                                            AppColors.primary,
                                                        onSelectionChanged:
                                                            (DateRangePickerSelectionChangedArgs
                                                                args) {
                                                          PickerDateRange
                                                              range = args.value
                                                                  as PickerDateRange;
                                                          setState(() {
                                                            params['startDate'] =
                                                                range
                                                                    .startDate!;
                                                            if (range.endDate !=
                                                                null) {
                                                              params['endDate'] =
                                                                  range.endDate;
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    PrimaryButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          this.params[
                                                                  'startDateTime'] =
                                                              params[
                                                                  'startDate'];
                                                          this.params[
                                                                  'endDateTime'] =
                                                              params['endDate'];
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                        fetchAppointments();
                                                      },
                                                      label:
                                                          'Confirm selection',
                                                      width: double.infinity,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            (params['startDateTime'] != null ||
                                                    params['endDateTime'] !=
                                                        null
                                                ? (formatter
                                                        .format(params[
                                                            'startDateTime'])
                                                        .toString() +
                                                    (params['endDateTime'] !=
                                                            null
                                                        ? ' - ${formatter.format(params['endDateTime'])}'
                                                        : ''))
                                                : 'Pick date'),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: params['startDateTime'] !=
                                                            null ||
                                                        params['endDateTime'] !=
                                                            null
                                                    ? AppColors.primary
                                                    : Colors.black,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.date_range_rounded,
                                            size: 16,
                                            color: AppColors.gray,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          newFirst = !newFirst;
                                        });
                                        sortData();
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            newFirst
                                                ? 'Oldest first'
                                                : 'Newest first',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            newFirst
                                                ? Icons.arrow_upward_outlined
                                                : Icons.arrow_downward_outlined,
                                            size: 16,
                                            color: AppColors.gray,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Show new only",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Checkbox(
                                            activeColor: AppColors.primary,
                                            value: showNewOnly,
                                            visualDensity:
                                                VisualDensity.compact,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                showNewOnly = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (appointments!['items'].length == 0)
                            const Padding(
                              padding: EdgeInsets.all(100),
                              child: Text(
                                'No appointments yet.',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: appointments!['items'].length,
                            itemBuilder: (context, index) {
                              var appointment = appointments!['items'][index];
                              return GestureDetector(
                                  onTap: () {
                                    if (appointment['startDateTime'] == null) {
                                      return;
                                    }
                                    showAppointmentDetails(
                                        context, appointment);
                                  },
                                  child: !showNewOnly ||
                                          (showNewOnly &&
                                              appointment['startDateTime'] ==
                                                  null)
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color:
                                                appointment['startDateTime'] ==
                                                        null
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
                                                appointment['pet']['owner']
                                                    ['fullName'],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('dd/MM/yyyy HH:mm')
                                                    .format(
                                                  DateTime.parse(
                                                      appointment['createdAt']),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
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
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    appointment['startDateTime'] ==
                                                            null
                                                        ? PrimaryButton(
                                                            onPressed: () =>
                                                                showAppointmentDetails(
                                                                    context,
                                                                    appointment),
                                                            label: "View",
                                                            width: 80,
                                                          )
                                                        : const Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: LightText(
                                                              label:
                                                                  "Appointment booked",
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox());
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
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
