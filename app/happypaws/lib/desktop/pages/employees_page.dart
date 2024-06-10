import 'dart:async';

import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/components/table/table_data.dart';
import 'package:happypaws/desktop/components/table/table_data_photo.dart';
import 'package:happypaws/desktop/components/table/table_head.dart';

import '../dialogs/add_edit_employee_dialog.dart';

@RoutePage()
class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  Map<String, dynamic>? employees;
  Timer? _debounce;
  Map<String, dynamic> params = {'role': 1};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response =
        await UsersService().getPaged("", 1, 999, searchObject: params);
    if (response.statusCode == 200) {
      setState(() {
        employees = response.data;
      });
    }
  }
onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        employees = null;
      });
      fetchData();
    });
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
                        .indexWhere((x) => x['id'] == value['value']['id'])] =
                    value['value'];
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
      var response = await UsersService().delete('/$id');
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Employee details',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                     SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            params['fullName'] = value;
                          });
                          onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Search by name...",
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                            suffixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  size: 25,
                                  color: AppColors.primary,
                                ))),
                      ),
                    ),
                    const SizedBox(width: 20,),
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
        1: FlexColumnWidth(2),
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
          children: const [
            TableHead(
              header: 'Id.',
              alignmentGeometry: Alignment.center,
              paddingHorizontal: 0,
            ),
            TableHead(
              header: 'Photo',
              alignmentGeometry: Alignment.center,
              paddingHorizontal: 0,
            ),
            TableHead(header: 'Name', alignmentGeometry: Alignment.center),
            TableHead(header: 'Email', alignmentGeometry: Alignment.center),
            TableHead(header: 'Role', alignmentGeometry: Alignment.center),
            TableHead(header: 'Actions', alignmentGeometry: Alignment.center),
          ],
        ),
        for (var employee in employees!['items'])
          TableRow(
            children: [
              TableData(data: employee['id'].toString()),
              employee['profilePhoto'] == null
                  ? const TableCell(
                      child: Image(
                        image: AssetImage("assets/images/user.png"),
                        height: 30,
                        width: 30,
                      ),
                    )
                  : TableDataPhoto(data: employee['profilePhoto']['data']),
              TableData(data: employee['fullName']),
              TableData(data: employee['email']),
              TableData(
                  data: employee['employeePosition'][0] +
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
                      insentPaddingX: 300,
                      title: 'Confirmation',
                      content:
                          'Deleting this employee will result in the deletion of all related data, including appointment history and any other associated information. This action cannot be undone. Please confirm that you want to proceed.',
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
}
