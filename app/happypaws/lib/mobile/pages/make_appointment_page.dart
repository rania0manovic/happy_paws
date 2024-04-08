import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AppointmentsService.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class MakeAppointmentPage extends StatefulWidget {
  final Map<String, dynamic>? data;
  const MakeAppointmentPage({super.key, this.data});

  @override
  State<MakeAppointmentPage> createState() => _MakeAppointmentPageState();
}

class _MakeAppointmentPageState extends State<MakeAppointmentPage> {
  Map<String, dynamic>? userPets;
  Map<String, dynamic> data = {};
  String? selectedValue;

  @override
  initState() {
    super.initState();
    if (widget.data != null) {
      data = widget.data!;
      userPets = {
        'items': [widget.data!['pet']]
      };
      selectedValue = widget.data!['pet']['id'].toString();
    } else {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    var user = await AuthService().getCurrentUser();
    var response = await PetsService()
        .getPaged('', 1, 999, searchObject: {'userId': user?['Id']});
    if (response.statusCode == 200) {
      setState(() {
        userPets = response.data;
        selectedValue = userPets!['items'][0]['id'].toString();
        data['petId'] = userPets!['items'][0]['id'];
      });
    }
  }

  Future<void> bookAppointment() async {
    try {
      var response = await AppointmentsService().post('', data);
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "Your request for the appointment has been successfully made! You will get notified once it gets approved.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return userPets == null
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
                      "Book an appointment",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Please pick your pet:',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    dropdownMenu(userPets!['items'], (newValue) {
                      setState(() {
                        selectedValue = newValue;
                        data['petId'] = newValue;
                      });
                    }, selectedValue),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Please describe your reason for visit:',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 6),
                      height: 200,
                      child: TextFormField(
                        readOnly: widget.data != null,
                        initialValue: data['reason'],
                        onChanged: (value) => setState(() {
                          data['reason'] = value;
                        }),
                        textInputAction: TextInputAction.done,
                        minLines: 10,
                        maxLines: 10,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 6),
                      height: 150,
                      child: TextFormField(
                        readOnly: widget.data != null,
                        initialValue: data['note'],
                        onChanged: (value) => setState(() {
                          data['note'] = value;
                        }),
                        textInputAction: TextInputAction.done,
                        minLines: 5,
                        maxLines: 5,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
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
                    SizedBox(
                      height: 20,
                    ),
                    if (widget.data == null)
                      PrimaryButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmationDialog(
                                title: 'Confirmation',
                                content:
                                    'Keep in mind that once your request is made, you won\'t be able to update the inserted data. Do you wish to proceed?',
                                onYesPressed: () {
                                  Navigator.of(context).pop();
                                  bookAppointment();
                                },
                                onNoPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                        label: "Send",
                        width: double.infinity,
                        fontSize: 18,
                      ),
                  ]),
            ),
          );
  }

  Container dropdownMenu(
    dynamic items,
    void Function(String? newValue) onChanged,
    String? selectedOption,
  ) {
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
              value: selectedOption,
              hint: const Text('Select'),
              underline: Container(),
              disabledHint: widget.data == null
                  ? null
                  : Text(widget.data!["pet"]["name"]),
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              onChanged: widget.data != null ? null : onChanged,
              items: [
                for (var item in items)
                  DropdownMenuItem<String>(
                    value: item['id'].toString(),
                    child: Text(item['name']),
                  ),
              ],
            ),
          ),
        ));
  }
}
