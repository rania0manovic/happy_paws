import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/EmployeesService.dart';
import 'package:happypaws/common/services/EnumsService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:image_picker/image_picker.dart';

class AddEditEmployeeMenu extends StatefulWidget {
  final VoidCallback onClose;
  final MyVoidCallback onAdd;
  final MyVoidCallback onEdit;
  final Map<String, dynamic>? data;

  const AddEditEmployeeMenu({
    Key? key,
    required this.onClose,
    this.data, required this.onAdd, required this.onEdit,
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
        data["photoFile"] = selectedImage.path;
      });
    }
  }

  Future<void> addEmployee() async {
    try {
      var response = await EmployeesService().postMultiPartRequest('', data);
      if (response.statusCode == 200) {
        widget.onAdd(response.data);
        widget.onClose();
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
        widget.onEdit(response.data);
        widget.onClose();
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
