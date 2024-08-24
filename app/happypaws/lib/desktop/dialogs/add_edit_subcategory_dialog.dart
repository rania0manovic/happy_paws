import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/ProductSubcategoriesService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/firebase_storage.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';

class AddEditSubcategoryMenu extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;
  final Map<String, dynamic>? allSubcategories;
  final Map<String, dynamic>? data;

  const AddEditSubcategoryMenu({
    Key? key,
    required this.onClose,
    required this.fetchData,
    this.data,
    this.allSubcategories,
  }) : super(key: key);

  @override
  State<AddEditSubcategoryMenu> createState() => _AddEditSubcategoryMenuState();
}

class _AddEditSubcategoryMenuState extends State<AddEditSubcategoryMenu> {
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();
  bool disabledButton = false;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = {...widget.data!};
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

  Future<void> addSubcategory() async {
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
      final response = await ProductSubcategoriesService().post("", data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully added a new subcategory!");
      }
    } on DioException catch (e) {
      setState(() {
        disabledButton = false;
      });
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

  Future<void> editSubcategory() async {
    try {
      setState(() {
        disabledButton = true;
      });
      dynamic imageUrl;
      if (selectedImage != null) {
        if (widget.data != null && widget.data!['photo'] != null) {
          imageUrl = await FirebaseStorageHelper.updateImage(
              selectedImage!, widget.data!['photo']['downloadURL']);
        } else {
          imageUrl = await FirebaseStorageHelper.addImage(selectedImage!);
        }
        if (imageUrl != null) {
          setState(() {
            data['downloadUrl'] = imageUrl['downloadUrl'];
          });
        }
      }
      final response = await ProductSubcategoriesService().put("", data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully updated subcategory information!");
      }
    } on DioException catch (e) {
      setState(() {
        disabledButton = false;
      });
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

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 340,
          child: Column(
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
                        ? 'Edit product subcategory'
                        : "Add new product subcategory",
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
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 20,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputField(
                              label: "Name:",
                              value: widget.data != null
                                  ? widget.data!['name']
                                  : '',
                              onChanged: (value) => setState(() {
                                data['name'] = value;
                              }),
                              customValidation: () {
                                if (widget.allSubcategories != null) {
                                  bool hasSameName = widget
                                          .allSubcategories!['items']
                                          .any((category) =>
                                              selectedImage == null &&
                                              category['name'] ==
                                                  data['name']) ??
                                      false;
                                  if (hasSameName) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                } else {
                                  return true;
                                }
                              },
                              customMessage:
                                  'Subcategory with the same name already exists or no changes have been detected!',
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const LightText(
                              label: "Image:",
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white38,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: selectedImage != null
                                        ? Image.file(selectedImage!)
                                        : widget.data != null
                                            ? Image.network(
                                                widget.data!['photo']
                                                    ['downloadURL'],
                                                height: 25,
                                              )
                                            : const Image(
                                                image: AssetImage(
                                                    "assets/images/gallery.png")),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: ActionButton(
                                      onPressed: _pickImage,
                                      icon: Icons.add,
                                      iconSize: 20,
                                      iconColor: AppColors.primary,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            PrimaryButton(
                                isDisabled: disabledButton,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.data == null &&
                                        selectedImage == null) {
                                      ToastHelper.showToastError(context,
                                          "Image is a required field!");
                                      return;
                                    }
                                    widget.data != null
                                        ? editSubcategory()
                                        : addSubcategory();
                                  }
                                },
                                width: double.infinity,
                                label: widget.data != null ? 'Edit' : "Add")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
            initialValue: widget.data != null ? widget.data!['name'] : '',
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
