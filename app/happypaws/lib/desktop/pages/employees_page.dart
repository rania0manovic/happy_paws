import 'dart:convert';
import 'package:happypaws/common/services/EmployeesService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';

import '../dialogs/add_edit_employee_dialog.dart';

@RoutePage()
class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  Map<String, dynamic>? employees;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await EmployeesService().getPaged("", 1, 999);
    if (response.statusCode == 200) {
      setState(() {
        employees = response.data;
      });
    }
  }

  void showAddEditEmployeeMenu(BuildContext context,
      {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 50, horizontal: 150),
          contentPadding: const EdgeInsets.all(8),
          content: AddEditEmployeeMenu(
            onAdd: (value) {
              setState(() {
                employees!['items'].add(value);
              });
            },
            onEdit: (value) {
              setState(() {
                employees!['items'][employees!['items']
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

  Future<void> deleteEmployee(int id) async {
    try {
      var response = await EmployeesService().delete('/$id');
      if (response.statusCode == 200) {
        setState(() {
          employees!['items'].removeWhere((x) => x['id'] == id);
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully removed the selected employee!");
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
                      'Employee details',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditEmployeeMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new employee"),
                  ],
                ),
                const SizedBox(height: 16.0),
                employees != null
                    ? (employees!.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Text(
                              'No employees added yet.',
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
        4: FlexColumnWidth(4),
        5: FlexColumnWidth(3),
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
            tableHead('Email'),
            tableHead('Role'),
            tableHead('Actions'),
          ],
        ),
        for (var employee in employees!['items'])
          TableRow(
            children: [
              tableCell(employee['id'].toString()),
              employee['profilePhoto'] == null
                  ? const TableCell(
                      child: Image(
                        image: AssetImage("assets/images/user.png"),
                        height: 30,
                        width: 30,
                      ),
                    )
                  : tableCellPhoto(employee['profilePhoto']['data']),
              tableCell(employee['fullName']),
              tableCell(employee['email']),
              tableCell(employee['employeePosition'][0] +
                  employee['employeePosition']
                      .split(RegExp(r'(?=[A-Z])'))
                      .join(' ')
                      .toLowerCase()
                      .substring(1)),
              tableActions(employee)
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
                showAddEditEmployeeMenu(context, data: data);
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
                      content: 'Are you sure you want to delete this employee?',
                      onYesPressed: () {
                        Navigator.of(context).pop();
                        deleteEmployee(data['id']);
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
