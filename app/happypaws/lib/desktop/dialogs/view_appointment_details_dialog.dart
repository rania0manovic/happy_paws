import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/AppointmentsService.dart';
import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/timePicker.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:intl/intl.dart';

class ViewAppointmentDetails extends StatefulHookWidget {
  const ViewAppointmentDetails(
      {super.key,
      required this.onClose,
      required this.appointment,
      required this.date});
  final AsyncCallback onClose;
  final Map<String, dynamic> appointment;
  final DateTime date;

  @override
  State<ViewAppointmentDetails> createState() => _ViewAppointmentDetailsState();
}

class _ViewAppointmentDetailsState extends State<ViewAppointmentDetails> {
  bool isBooking = false;
  Map<String, dynamic>? employees;
  Map<String, dynamic> data = {};
  String selectedEmployee = "";
  bool isDisabledButton = false;

  @override
  initState() {
    super.initState();
  }

  Future<void> fetchSetData() async {
    try {
      data['date'] = DateFormat("yyyy.MM.dd").format(widget.date).toString();
      var response = await UsersService()
          .getFromQuery("/FreeEmployees", searchObject: data);
      if (response.statusCode == 406) {
        if (!mounted) return;
        ToastHelper.showToastWarning(context,
            "There are currently no free specialists available for the selected date/time. Please check the calendar again and pick a different date/time.");
      }
      if (response.statusCode == 200) {
        setState(() {
          employees = response.data;
          selectedEmployee = response.data['items'][0]['id'].toString();
          data['employeeId'] = response.data['items'][0]['id'].toString();
          data['appointmentId'] = widget.appointment['id'].toString();
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> bookAppointment() async {
    try {
      setState(() {
        isDisabledButton = true;
      });
      var response = await AppointmentsService()
          .getFromQuery("/BookAppointment", searchObject: data);
      if (response.statusCode == 200) {
        setState(() {
          isDisabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "The appointment has been succesfully booked!");
        await widget.onClose.call();
      }
    } catch (e) {
      setState(() {
        isDisabledButton = false;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (data['startDateTime'] != null && data['endDateTime'] != null) {
        fetchSetData();
      }
      return null;
    }, [data['startDateTime'], data['endDateTime']]);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const IconButton(
              icon: Icon(Icons.calendar_today_outlined),
              onPressed: null,
              color: AppColors.gray,
            ),
            Text(
              isBooking ? "Book the appointment" : "Appointment details",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: widget.onClose,
              icon: const Icon(Icons.close),
              color: Colors.grey,
            ),
          ],
        ),
        !isBooking
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Owner name: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.appointment['pet']['owner']['fullName'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Pet name: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.appointment['pet']['name'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "MyPaw number: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.onClose();
                              context.router.push(PatientsRoute(
                                  myPawNumber: widget.appointment['pet']
                                      ['owner']['myPawNumber']));
                            },
                            child: Text(
                              widget.appointment['pet']['owner']['myPawNumber'],
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary,
                                  color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          const Text(
                            "Reason: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.appointment['reason'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (widget.appointment['note'] != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Note: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.appointment['note'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Date created: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy HH:mm').format(
                                DateTime.parse(
                                    widget.appointment['createdAt'])),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (widget.appointment['startDateTime'] != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Appointment date: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                  widget.appointment['startDateTime'])),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    if (widget.appointment['startDateTime'] != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Appointment time: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${DateFormat('HH:mm').format(DateTime.parse(widget.appointment['startDateTime']))} - ${DateFormat('HH:mm').format(DateTime.parse(widget.appointment['endDateTime']))}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    if (widget.appointment['employee'] != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Employee appointed: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.appointment['employee']['fullName'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  LightText(
                    label:
                        "Date selected : ${DateFormat('dd/MM/yyyy').format(widget.date)}",
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TimeSlotSelectionPage(
                    onStartTimeChanged: (timeOfDay) {
                      setState(() {
                        data['startDateTime'] =
                            timeOfDay.format(context).toString();
                      });
                    },
                    onEndTimeChanged: (timeOfDay) => setState(() {
                      data['endDateTime'] =
                          timeOfDay.format(context).toString();
                    }),
                  ),
                  if (selectedEmployee != "") specialistsDropdown(),
                ],
              ),
        const SizedBox(
          height: 10,
        ),
        if (isBooking)
          PrimaryButton(
            isDisabled: isDisabledButton,
            onPressed: selectedEmployee != "" ? () => bookAppointment() : null,
            label: "Book",
            width: double.infinity,
            fontSize: 16,
          ),
        const SizedBox(
          height: 10,
        ),
        isBooking
            ? PrimaryButton(
                onPressed: () => setState(() {
                  isBooking = false;
                }),
                label: "Cancel",
                width: double.infinity,
                fontSize: 16,
                backgroundColor: AppColors.error,
              )
            : Visibility(
                visible: widget.appointment['startDateTime'] == null,
                child: PrimaryButton(
                  onPressed: () => setState(() {
                    isBooking = true;
                  }),
                  label: "Book appointment",
                  width: double.infinity,
                  fontSize: 16,
                ),
              ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Column specialistsDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const LightText(
          label: "Select specialist:",
          fontSize: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: double.infinity,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedEmployee,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEmployee = newValue!;
                      data['employeeId'] = selectedEmployee;
                    });
                  },
                  items: [
                    for (var item in employees!['items'])
                      DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['fullName'] +
                            " (" +
                            item['employeePosition'][0] +
                            item['employeePosition']
                                .split(RegExp(r'(?=[A-Z])'))
                                .join(' ')
                                .toLowerCase()
                                .substring(1) +
                            ")"),
                      ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
