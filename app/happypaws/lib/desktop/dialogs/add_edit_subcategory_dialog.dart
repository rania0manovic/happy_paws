import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/ProductSubcategoriesService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:image_picker/image_picker.dart';

class AddEditSubcategoryMenu extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;

  final Map<String, dynamic>? data;

  const AddEditSubcategoryMenu({
    Key? key,
    required this.onClose,
    required this.fetchData,
    this.data,
  }) : super(key: key);

  @override
  _AddEditSubcategoryMenuState createState() => _AddEditSubcategoryMenuState();
}

class _AddEditSubcategoryMenuState extends State<AddEditSubcategoryMenu> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = widget.data!;
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
      final response = await ProductSubcategoriesService().post("", data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editSubcategory() async {
    try {
      final response = await ProductSubcategoriesService().put("", widget.data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        inputField("Name:", "name"),
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
                                  color: AppColors.dimWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: _selectedImage != null
                                    ? Image.file(_selectedImage!)
                                    : widget.data != null
                                        ? Image.memory(
                                            base64.decode(widget.data!['photo']
                                                    ['data']
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
                            onPressed: () {
                              widget.data != null
                                  ? editSubcategory()
                                  : addSubcategory();
                            },
                            width: double.infinity,
                            label: widget.data != null ? 'Edit' : "Add")
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
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
                color:  Colors.black,
              ),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                filled: true,
                fillColor:  AppColors.dimWhite,
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
