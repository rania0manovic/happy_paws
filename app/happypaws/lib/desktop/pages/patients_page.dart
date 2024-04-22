import 'dart:convert';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';

import '../dialogs/add_edit_patient_dialog.dart';

@RoutePage()
class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  Map<String, dynamic>? patients;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await PetsService().getPaged("", 1, 999);
    if (response.statusCode == 200) {
      setState(() {
        patients = response.data;
      });
    }
  }

  void showAddEditPatientMenu(BuildContext context,
      {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 150),
          contentPadding: const EdgeInsets.all(8),
          content: AddEditPatientMenu(
            onAdd: (value) {
              setState(() {
                patients!['items'].add(value);
              });
            },
            onEdit: (value) {
              setState(() {
                patients!['items'][patients!['items']
                    .indexWhere((x) => x['id'] == value['id'])] = value;
              });
            },
            data: data,
            onClose: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Future<void> deletePatient(int id) async {
    try {
      var response = await PetsService().delete('/$id');
      if (response.statusCode == 200) {
        patients!['items'].removeWhere((x) => x['id'] == id);
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully removed the selected patient!");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Patient details',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditPatientMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new patient"),
                  ],
                ),
                const SizedBox(height: 16.0),
                patients != null
                    ? (patients!.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Text(
                              'No patient added yet.',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ))
                        : Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical, child: table()),
                          ))
                    : const Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 36.0),
                            child: Spinner()))
              ],
            ),
          ),
        ));
  }

  Table table() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(4),
        3: FlexColumnWidth(4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        horizontalInside: BorderSide(
          color: AppColors.gray.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
          ),
          children: [
            tableHead('Id'),
            tableHead('Photo'),
            tableHead('Name'),
            tableHead('Breed'),
            tableHead('Actions'),
          ],
        ),
        for (var patient in patients!['items'])
          TableRow(
            children: [
              tableCell(patient['id'].toString()),
              patient['photo'] == null
                  ? const TableCell(
                      child: Image(
                        image: AssetImage("assets/images/user.png"),
                        height: 30,
                        width: 30,
                      ),
                    )
                  : tableCellPhoto(patient['photo']['data']),
              tableCell(patient['name']),
              tableCell(patient['petBreed']['name']),
              tableActions(patient)
            ],
          )
      ],
    );
  }

  TableCell tableCell(String data) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
            child: Tooltip(
          message: data.length > 20 ? data : '',
          child: Text(
            data.length > 30 ? '${data.substring(0, 30)}...' : data,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )),
      ),
    );
  }

  TableCell tableCellPhoto(String data) {
    return TableCell(
        child: SizedBox(
      height: 40,
      width: 40,
      child: FittedBox(
        fit: BoxFit.contain,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Image.memory(
            base64.decode(
              data.toString(),
            ),
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              onPressed: () {
                showAddEditPatientMenu(context, data: data);
              },
              icon: Icons.edit_outlined,
              iconColor: AppColors.gray,
            ),
            ActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationDialog(
                      title: 'Confirmation',
                      content: 'Are you sure you want to delete this patient?',
                      onYesPressed: () {
                        Navigator.of(context).pop();
                        deletePatient(data['id']);
                      },
                      onNoPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              icon: Icons.delete_outline_outlined,
              iconColor: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  TableCell tableHead(String header) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            header,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
