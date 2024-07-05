import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/BrandsService.dart';
import 'package:happypaws/common/services/ImagesService.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/common/utilities/firebase_storage.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/api_data_dropdown_menu.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';

class AddEditProductMenu extends StatefulWidget {
  final VoidCallback onClose;
  final MyVoidCallback onEdit;
  final MyVoidCallback onAdd;
  final Map<String, dynamic>? data;

  const AddEditProductMenu({
    Key? key,
    required this.onClose,
    this.data,
    required this.onEdit,
    required this.onAdd,
  }) : super(key: key);

  @override
  State<AddEditProductMenu> createState() => _AddEditProductMenuState();
}

class _AddEditProductMenuState extends State<AddEditProductMenu> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedBrand;
  Map<String, dynamic>? productCategories;
  List<dynamic>? productSubcategories;
  Map<String, dynamic>? productBrands;
  final List<File> _selectedImages = [];
  List<Map<String, dynamic>> productImages = [];
  int activeImageId = 0;
  int activeImageIndex = 0;
  bool disabledButton = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = widget.data!;
    }
    fetchData();
  }

  Future<void> fetchData() async {
    var responseCategories =
        await ProductCategoriesService().getPaged("", 1, 999);
    if (responseCategories.statusCode == 200) {
      setState(() {
        productCategories = responseCategories.data;
        if (widget.data != null) {
          selectedCategory = widget.data!['productCategorySubcategory']
                  ['productCategoryId']
              .toString();
          fetchSubcategories(selectedCategory);
          selectedSubCategory =
              widget.data!['productCategorySubcategory']['id'].toString();
          productImages =
              List<Map<String, dynamic>>.from(widget.data!['productImages']);
        }
      });
    }

    var responseBrands = await BrandsService().getPaged("", 1, 999);
    if (responseBrands.statusCode == 200) {
      setState(() {
        productBrands = responseBrands.data;
        if (widget.data != null) {
          selectedBrand = widget.data!['brandId'].toString();
        }
      });
    }
  }

  Future<void> fetchSubcategories(String? newValue) async {
    var responseSubcategories =
        await ProductCategorySubcategoriesService().getSubcategories(newValue);
    if (responseSubcategories.statusCode == 200) {
      setState(() {
        productSubcategories = responseSubcategories.data;
      });
    }
  }

  Future<dynamic> _pickImage() async {
    if (productImages.length >= 6) return;
    var result = await FirebaseStorageHelper.pickImage();
    if (result != null) {
      setState(() {
        _selectedImages.add(result['selectedImage']);
        dynamic photo = {
          'image': {'file': result['selectedImage']}
        };
        productImages.add(photo);
      });
    }
  }

  Future<void> addProduct() async {
    try {
      setState(() {
        disabledButton = true;
      });
      if (_selectedImages.isNotEmpty) {
        var downloadURLs = [];
        for (var item in _selectedImages) {
          var imageUrl = await FirebaseStorageHelper.addImage(item);
          if (imageUrl != null) {
            setState(() {
              downloadURLs.add(imageUrl['downloadUrl']);
            });
          }
          data['downloadURLs'] = downloadURLs;
        }
      }
      var response = await ProductsService().post('', data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.onAdd(response.data);
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully added a new product! Make sure to activate it once it's ready for selling!");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } catch (e) {
      setState(() {
        disabledButton = false;
      });
      rethrow;
    }
  }

  Future<void> editProduct() async {
    try {
      setState(() {
        disabledButton = true;
      });
      if (_selectedImages.isNotEmpty) {
        var downloadURLs = [];
        for (var item in _selectedImages) {
          var imageUrl = await FirebaseStorageHelper.addImage(item);
          if (imageUrl != null) {
            setState(() {
              downloadURLs.add(imageUrl['downloadUrl']);
            });
          }
          data['downloadURLs'] = downloadURLs;
        }
      }
      var response = await ProductsService().put('', data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.onEdit(response.data);
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully updated product information!");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } catch (e) {
      setState(() {
        disabledButton = false;
      });
      rethrow;
    }
  }

  Future<void> deleteImage() async {
    try {
      if (activeImageId != 0) {
        var downloadUrl =
            productImages.elementAt(activeImageIndex)['image']['downloadURL'];
        await FirebaseStorageHelper.removeImage(downloadUrl);
        var response = await ImagesService().delete('/$activeImageId');
        if (response.statusCode == 200) {
          if (!mounted) return;
          ToastHelper.showToastSuccess(
              context, "You have successfully removed selected image!");
        }
      }
      setState(() {
        var element = productImages.elementAt(activeImageIndex);
        _selectedImages.removeWhere((x) => x == element['image']['file']);
        productImages.removeAt(activeImageIndex);
      });
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: (productCategories == null || productBrands == null)
          ? const Spinner()
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                              ? "Edit product"
                              : "Add new product",
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
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      child: SingleChildScrollView(
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 20,
                          children: [
                            FractionallySizedBox(
                              widthFactor: 0.33,
                              child: Column(
                                children: [
                                  InputField(
                                    label: "Name:",
                                    value: widget.data != null
                                        ? widget.data!['name']
                                        : '',
                                    onChanged: (value) => setState(() {
                                      data['name'] = value;
                                    }),
                                  ),
                                  InputField(
                                    label: "Price:",
                                    value: widget.data != null
                                        ? widget.data!['price'].toString()
                                        : '',
                                    isNumber: true,
                                    onChanged: (value) => setState(() {
                                      data['price'] = value;
                                    }),
                                  ),
                                  textBox("Description:", "description"),
                                ],
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InputField(
                                    label: "UPC:",
                                    value: widget.data != null
                                        ? widget.data!['upc']
                                        : '',
                                    onChanged: (value) => setState(() {
                                      data['upc'] = value;
                                    }),
                                  ),
                                  ApiDataDropdownMenu(
                                    items: productCategories!['items'],
                                    onChanged: (String? newValue) async {
                                      setState(() {
                                        selectedSubCategory = null;
                                        selectedCategory = null;
                                      });
                                      await fetchSubcategories(newValue);
                                      setState(() {
                                        selectedCategory = newValue;
                                      });
                                    },
                                    selectedOption: selectedCategory,
                                    label: "Category:",
                                  ),
                                  ApiDataDropdownMenu(
                                      items: productSubcategories == null
                                          ? List.empty()
                                          : productSubcategories!,
                                      onChanged: (String? newValue) =>
                                          setState(() {
                                            selectedSubCategory = newValue;
                                            data['productCategorySubcategoryId'] =
                                                newValue;
                                          }),
                                      selectedOption: selectedSubCategory,
                                      label: "Subcategory:",
                                      isDisabled: selectedCategory == null
                                          ? true
                                          : false),
                                  ApiDataDropdownMenu(
                                    items: productBrands!['items'],
                                    onChanged: (String? newValue) =>
                                        setState(() {
                                      selectedBrand = newValue;
                                      data['brandId'] = newValue;
                                    }),
                                    selectedOption: selectedBrand,
                                    label: "Brand:",
                                  )
                                ],
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.3,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: 210,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: productImages.isNotEmpty
                                          ? Stack(children: [
                                              Swiper(
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              32.0),
                                                      child: productImages[
                                                                          index]
                                                                      ['image']
                                                                  ['file'] !=
                                                              null
                                                          ? Image.file(
                                                              productImages[
                                                                          index]
                                                                      ['image']
                                                                  ['file'],
                                                            )
                                                          : Image.network(
                                                              productImages[
                                                                          index]
                                                                      ['image'][
                                                                  'downloadURL'],
                                                            ));
                                                },
                                                onIndexChanged: (value) =>
                                                    setState(() {
                                                  if (productImages[value]
                                                          ['image']['id'] !=
                                                      null) {
                                                    activeImageId =
                                                        productImages[value]
                                                            ['image']['id'];
                                                  } else {
                                                    activeImageId = 0;
                                                  }
                                                  activeImageIndex = value;
                                                }),
                                                itemCount: productImages.length,
                                                pagination:
                                                    const SwiperPagination(
                                                  builder:
                                                      DotSwiperPaginationBuilder(
                                                    activeColor:
                                                        AppColors.primary,
                                                  ),
                                                ),
                                                control: const SwiperControl(
                                                    color: AppColors.primary,
                                                    size: 16),
                                              ),
                                              Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: ActionButton(
                                                    onPressed: _pickImage,
                                                    icon: Icons.add,
                                                    iconSize: 20,
                                                    iconColor:
                                                        AppColors.primary,
                                                  )),
                                              Positioned(
                                                  bottom: 0,
                                                  right: 20,
                                                  child: ActionButton(
                                                    onPressed: () {
                                                      if (productImages
                                                              .length ==
                                                          1) {
                                                        ToastHelper.showToastError(
                                                            context,
                                                            "Product must have at least one photo saved! Please add new photo and save changes before deleting the current one.");
                                                        return;
                                                      }
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return ConfirmationDialog(
                                                            title:
                                                                'Confirmation',
                                                            content:
                                                                'Are you sure you want to delete this photo? This action cannot be undone and will take place immediatly.',
                                                            onYesPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              deleteImage();
                                                            },
                                                            onNoPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icons
                                                        .delete_forever_rounded,
                                                    iconSize: 20,
                                                    iconColor: AppColors.error,
                                                  ))
                                            ])
                                          : GestureDetector(
                                              onTap: _pickImage,
                                              child: const Icon(
                                                Icons.add,
                                                size: 20,
                                                color: AppColors.primary,
                                              ))),
                                  const SizedBox(
                                    height: 55,
                                  ),
                                  PrimaryButton(
                                    isDisabled: disabledButton,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (_selectedImages.isEmpty &&
                                            productImages.isEmpty) {
                                          ToastHelper.showToastError(context,
                                              "You must add at least one image for product!");
                                          return;
                                        }
                                        widget.data != null
                                            ? editProduct()
                                            : addProduct();
                                      }
                                    },
                                    fontSize: 16,
                                    label: widget.data != null
                                        ? "Edit product"
                                        : "Add product",
                                    width: double.infinity,
                                  )
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

  Column dropdownMenu(dynamic items, String label,
      void Function(String? newValue) onChanged, String? selectedOption,
      {bool isDisabeled = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        LightText(
          label: label,
          fontSize: 14,
        ),
        Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: selectedOption,
                hint: const Text('Select'),
                underline: Container(),
                focusColor: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                onChanged: isDisabeled ? null : onChanged,
                disabledHint: const Text("Select category first..."),
                items: [
                  for (var item in items)
                    DropdownMenuItem<String>(
                      value: item['id'].toString(),
                      child: items == productSubcategories
                          ? Text(item['productSubcategory']['name'])
                          : Text(item['name']),
                    ),
                ],
              ),
            )),
      ],
    );
  }

  Column textBox(String label, String key) {
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
        Container(
          padding: const EdgeInsets.only(top: 10),
          height: 130,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            initialValue: widget.data != null
                ? widget.data![key[0].toLowerCase() + key.substring(1)]
                    .toString()
                : '',
            onChanged: (value) => setState(() {
              data[key] = value;
            }),
            minLines: 10,
            maxLines: 10,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            decoration: InputDecoration(
                errorStyle:
                    const TextStyle(color: AppColors.error, fontSize: 14),
                filled: true,
                fillColor: AppColors.fill,
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
        ),
      ],
    );
  }
}
