import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddEditCategoryOverlay extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? allCategories;
  final Map<String, dynamic>? subcategories;
  List<int>? listIds;

  AddEditCategoryOverlay(
      {Key? key,
      required this.onClose,
      required this.fetchData,
      this.data,
      this.subcategories,
      this.listIds,
      this.allCategories})
      : super(key: key);

  @override
  _AddEditCategoryOverlayState createState() => _AddEditCategoryOverlayState();
}

class _AddEditCategoryOverlayState extends State<AddEditCategoryOverlay> {
  final _formKey = GlobalKey<FormState>();
  late List<bool> isCheckedList =
      List.generate(widget.subcategories!['totalCount'], (index) => false);
  final ImagePicker _imagePicker = ImagePicker();
  List<int> listIds = [];
  bool disabledButton = false;

  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = {...widget.data!};
    }
    if (widget.listIds != null) {
      isCheckedList = List.generate(
          widget.subcategories!['totalCount'],
          (index) => widget.data != null && widget.listIds != null
              ? widget.listIds!
                  .contains(widget.subcategories!['items'][index]['id'])
              : false);
      listIds = [...widget.listIds!];
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

  Future<void> addCategory() async {
    try {
      setState(() {
        disabledButton = true;
      });
      widget.listIds ??= [];
      data['addedIds'] = listIds;
      final response = await ProductCategoriesService().post("", data);
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have succesfully added a new category. Keep in mind that it may take up to 24 hours for changes to take place.");
        widget.onClose();
        widget.fetchData();
        setState(() {
          disabledButton = false;
        });
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

  Future<void> editCategory() async {
    try {
      setState(() {
        disabledButton = true;
      });
      widget.listIds ??= [];
      List<int> addedValues = listIds
          .where((element) => !widget.listIds!.contains(element))
          .toList();
      List<int> removedValues = widget.listIds!
          .where((element) => !listIds.contains(element))
          .toList();
      if (addedValues.isNotEmpty) data['addedIds'] = addedValues;
      if (removedValues.isNotEmpty) data['removedIds'] = removedValues;
      if (removedValues.isNotEmpty && removedValues.length >= listIds.length && addedValues.isEmpty) {
        ToastHelper.showToastError(
            context, "You must select at least one subcategory!");
             setState(() {
        disabledButton = false;
      });
        return;
      }
      final response =
          await ProductCategoriesService().put("", data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have succesfully updated category information. Keep in mind that it may take up to 24 hours for changes to take place.");
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
      child: Container(
        width: 400,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        ? 'Edit product category'
                        : "Add new product category",
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 20,
                      children: [
                        SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
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
                                    if (widget.allCategories != null) {
                                      bool hasSameName = widget
                                              .allCategories!['items']
                                              .any((category) =>
                                                  category['id'] !=
                                                      data['id'] &&
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
                                      'Category with the same name already exists!',
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
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          spacing: 16.0,
                                          runSpacing: 8.0,
                                          children: List.generate(
                                            widget.subcategories!['totalCount'],
                                            (index) => Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Checkbox(
                                                  activeColor:
                                                      AppColors.primary,
                                                  value: isCheckedList[index],
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      setState(() {
                                                        isCheckedList[index] =
                                                            value!;
                                                        if (value) {
                                                          listIds.add(
                                                              widget.subcategories![
                                                                      'items'][
                                                                  index]['id']);
                                                        } else {
                                                          listIds.remove(
                                                              widget.subcategories![
                                                                      'items'][
                                                                  index]['id']);
                                                        }
                                                      });
                                                    });
                                                  },
                                                ),
                                                Text(widget
                                                        .subcategories!['items']
                                                    [index]['name']),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                              "Image is a required field and you must select at least one subcategory!");
                                          return;
                                        }
                                        widget.data != null
                                            ? editCategory()
                                            : addCategory();
                                      }
                                    },
                                    width: double.infinity,
                                    label: widget.data != null ? 'Edit' : "Add")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
