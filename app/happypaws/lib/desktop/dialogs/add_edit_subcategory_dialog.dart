import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/ProductSubcategoriesService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:image_picker/image_picker.dart';

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
  _AddEditSubcategoryMenuState createState() => _AddEditSubcategoryMenuState();
}

class _AddEditSubcategoryMenuState extends State<AddEditSubcategoryMenu> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  bool disabledButton = false;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = {...widget.data!};
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

  Future<void> addSubcategory() async {
    try {
      setState(() {
        disabledButton = true;
      });
      final response = await ProductSubcategoriesService().post("", data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have succesfully added a new subcategory. Keep in mind that it may take up to 24 hours for changes to take place.");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editSubcategory() async {
    try {
      setState(() {
        disabledButton = true;
      });
      final response = await ProductSubcategoriesService().put("", data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have succesfully updated subcategory information. Keep in mind that it may take up to 24 hours for changes to take place.");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } catch (e) {
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
                              value:
                                  widget.data != null ? widget.data!['name'] : '',
                              onChanged: (value) => setState(() {
                                data['name'] = value;
                              }),
                              customValidation: () {
                                if (widget.allSubcategories != null) {
                                  bool hasSameName = widget
                                          .allSubcategories!['items']
                                          .any((category) =>
                                              data['photoFile'] == null &&
                                              category['name'] == data['name']) ??
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
                                    child: _selectedImage != null
                                        ? Image.file(_selectedImage!)
                                        : widget.data != null
                                            ? Image.memory(
                                                base64.decode(widget
                                                    .data!['photo']['data']
                                                    .toString()),
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
                                        data["photoFile"] == null) {
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
