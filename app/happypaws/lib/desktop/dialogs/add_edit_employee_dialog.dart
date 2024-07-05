import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/EnumsService.dart';
import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/firebase_storage.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/gender_dropdown_menu.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';

class AddEditEmployeeMenu extends StatefulWidget {
  final VoidCallback onClose;
  final MyVoidCallback onAdd;
  final MyVoidCallback onEdit;
  final Map<String, dynamic>? data;

  const AddEditEmployeeMenu({
    Key? key,
    required this.onClose,
    this.data,
    required this.onAdd,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<AddEditEmployeeMenu> createState() => _AddEditEmployeeMenuState();
}

class _AddEditEmployeeMenuState extends State<AddEditEmployeeMenu> {
  Map<String, dynamic> data = {};
  String selectedGender = "Unknown";
  String selectedRole = '';
  File? selectedImage;
  Map<String, dynamic>? profilePhoto;
  List<dynamic>? employeePositions;
  bool disabledButton = false;

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
        if (widget.data == null) {
          data['employeePosition'] = response.data[0]['value'];
        }
        selectedRole = widget.data != null
            ? widget.data!['employeePosition']
            : response.data[0]['value'];
        employeePositions = response.data;
      });
    }
  }

  Future<dynamic> _pickImage() async {
    var result = await FirebaseStorageHelper.pickImage();
    if (result != null) {
      setState(() {
        selectedImage = result['selectedImage'];
      });
    }
  }

  Future<void> addEmployee() async {
    try {
      setState(() {
        disabledButton = true;
      });
      dynamic imageUrl;
      if (selectedImage != null) {
        imageUrl = await FirebaseStorageHelper.addImage(selectedImage!);
        if (imageUrl != null) {
          setState(() {
            data['downloadUrl'] = imageUrl['downloadUrl'];
          });
        }
      }
      var response = await UsersService().post('', data);
      if (response.statusCode == 200) {
        widget.onAdd(response.data);
        widget.onClose();
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully added a new employee!");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      }
      rethrow;
    }
  }

  Future<void> editEmployee() async {
    try {
      setState(() {
        disabledButton = true;
      });
      dynamic imageUrl;
      if (selectedImage != null) {
        if (widget.data != null && widget.data!['image'] != null) {
          imageUrl = await FirebaseStorageHelper.updateImage(
              selectedImage!, widget.data!['image']['downloadURL']);
        } else {
          imageUrl = await FirebaseStorageHelper.addImage(selectedImage!);
        }
        if (imageUrl != null) {
          setState(() {
            data['downloadUrl'] = imageUrl['downloadUrl'];
          });
        }
      }
      var response = await UsersService().put('', widget.data);
      if (response.statusCode == 200) {
        widget.onEdit(response.data);
        widget.onClose();
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully edited selected employee information!");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: selectedImage != null
                                            ? Image.file(
                                                selectedImage!,
                                                fit: BoxFit.cover,
                                              )
                                            : (widget.data != null &&
                                                      widget.data!['profilePhoto'] !=
                                                          null)
                                                  ? Image.network(
                                                      widget.data!['profilePhoto']
                                                          ['downloadURL'],
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
                                    InputField(
                                      label: "First name:",
                                      value: widget.data != null
                                          ? widget.data!['firstName']
                                          : '',
                                      onChanged: (value) => setState(() {
                                        data['firstName'] = value;
                                      }),
                                    ),
                                    InputField(
                                      label: "Email:",
                                      value: widget.data != null
                                          ? widget.data!['email']
                                          : '',
                                      onChanged: (value) => setState(() {
                                        data['email'] = value;
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.48,
                                child: Column(
                                  children: [
                                    InputField(
                                      label: "Last name:",
                                      value: widget.data != null
                                          ? widget.data!['lastName']
                                          : '',
                                      onChanged: (value) => setState(() {
                                        data['lastName'] = value;
                                      }),
                                    ),
                                    GenderDropdownMenu(
                                      selectedGender: selectedGender,
                                      onChanged: (newValue) => setState(() {
                                        selectedGender = newValue!;
                                        data['gender'] = newValue;
                                      }),
                                    ),
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
                            isDisabled: disabledButton,
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
                color: AppColors.fill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
            )),
      ],
    );
  }
}
