import 'dart:convert';
import 'package:happypaws/common/services/EmployeesService.dart';
import 'package:happypaws/common/services/EnumsService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/desktop/components/dialogs/confirmationDialog.dart';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:image_picker/image_picker.dart';

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
            data: data,
            fetchData: fetchData,
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
        fetchData();
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

class AddEditEmployeeMenu extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;
  final Map<String, dynamic>? data;

  const AddEditEmployeeMenu({
    Key? key,
    required this.onClose,
    required this.fetchData,
    this.data,
  }) : super(key: key);

  @override
  _AddEditEmployeeMenuState createState() => _AddEditEmployeeMenuState();
}

class _AddEditEmployeeMenuState extends State<AddEditEmployeeMenu> {
  Map<String, dynamic> data = {};
  String selectedGender = "Unknown";
  String selectedRole = '';
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  Map<String, dynamic>? profilePhoto;
  List<dynamic>? employeePositions;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = widget.data!;
      selectedGender = widget.data!["gender"];
    }
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await EnumsService().getEmployeePositions();
    if (response.statusCode == 200) {
      setState(() {
        selectedRole = response.data[0]['value'];
        employeePositions = response.data;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = File(selectedImage.path);
        data["PhotoFile"] = selectedImage.path;
      });
    }
  }

  Future<void> addEmployee() async {
    try {
      var response = await EmployeesService().postMultiPartRequest('', data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully added a new employee!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editEmployee() async {
    try {
      var response =
          await EmployeesService().putMultiPartRequest('', widget.data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully edited selected employee information!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width,
      child: employeePositions == null
          ? const Spinner()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const IconButton(
                      icon: Icon(Icons.inventory_2_outlined),
                      onPressed: null,
                      color: AppColors.gray,
                    ),
                    Text(
                      widget.data != null
                          ? "Edit employee"
                          : "Add new employee",
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
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 128,
                            width: 128,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 128,
                                  width: 128,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: _selectedImage != null
                                          ? Image.file(
                                              _selectedImage!,
                                              fit: BoxFit.cover,
                                            )
                                          : (widget.data != null &&
                                                  widget.data![
                                                          'profilePhoto'] !=
                                                      null)
                                              ? Image.memory(
                                                  base64.decode(widget
                                                      .data!['profilePhoto']
                                                          ['data']
                                                      .toString()),
                                                  fit: BoxFit.cover)
                                              : const Image(
                                                  image: AssetImage(
                                                      "assets/images/user.png"),
                                                  fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () => _pickImage(),
                                      child: const Image(
                                          image: AssetImage(
                                              "assets/images/edit.png")),
                                    ))
                              ],
                            )),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 10,
                          children: [
                            FractionallySizedBox(
                              widthFactor: 0.48,
                              child: Column(
                                children: [
                                  inputField("First name:", "firstName"),
                                  inputField("Email: ", "email"),
                                ],
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.48,
                              child: Column(
                                children: [
                                  inputField("Last name:", "lastName"),
                                  genderDropdownMenu(),
                                ],
                              ),
                            ),
                            positionsDropdownMenu()
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        PrimaryButton(
                          onPressed: () => widget.data != null
                              ? editEmployee()
                              : addEmployee(),
                          label: widget.data != null
                              ? "Edit employee information"
                              : "Add new employee",
                          width: double.infinity,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Column positionsDropdownMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const LightText(
          label: "Position:",
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
                  value: selectedRole,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                      data['employeePosition'] = newValue;
                    });
                  },
                  items: [
                    for (var item in employeePositions!)
                      DropdownMenuItem<String>(
                        value: item['value'].toString(),
                        child: Text(item['value'][0] +
                            item['value']
                                .split(RegExp(r'(?=[A-Z])'))
                                .join(' ')
                                .toLowerCase()
                                .substring(1)),
                      ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Column genderDropdownMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const LightText(
          label: "Gender:",
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
                  value: selectedGender,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                      data['gender'] = newValue;
                    });
                  },
                  items: <String>[
                    'Unknown',
                    'Female',
                    'Male',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    );
                  }).toList(),
                ),
              ),
            )),
      ],
    );
  }

  Column inputField(String label, String key, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        LightText(
          label: label,
          fontSize: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: TextFormField(
            initialValue: widget.data != null
                ? widget.data![key[0].toLowerCase() + key.substring(1)]
                    .toString()
                : '',
            onChanged: (value) {
              setState(() {
                data[key] = value;
              });
            },
            style: const TextStyle(
              color: Colors.black,
            ),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                filled: true,
                fillColor: AppColors.dimWhite,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
