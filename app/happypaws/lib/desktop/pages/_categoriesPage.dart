import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/common/services/ProductSubcategoriesService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/ActionButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryIconButton.dart';
import 'package:happypaws/desktop/components/dialogs/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<CategoriesPage> {
  List<Map<String, dynamic>>? productCategories;
  List<Map<String, dynamic>>? productSubcategories;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var responseCategories =
        await ProductCategoriesService().getPaged("", 1, 999);
    if (responseCategories.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseCategories.body);
      setState(() {
        productCategories = List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
    var responseSubcategories =
        await ProductSubcategoriesService().getPaged("", 1, 999);
    if (responseSubcategories.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseSubcategories.body);
      setState(() {
        productSubcategories =
            List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      var response = await ProductCategoriesService().delete('/$id');
      if (response.statusCode == 200) {
        fetchData();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>?> fetchSubcategoryIds(Map<String, dynamic> data) async {
    int categoryId = data['id'];
    var response = await ProductCategorySubcategoriesService()
        .getSubcategoryIds(categoryId);

    if (response.statusCode == 200) {
      return json.decode(response.body).cast<int>();
    } else {
      return null;
    }
  }

  Future<void> showAddEditMenu(BuildContext context,
      {Map<String, dynamic>? data}) async {
    List<int>? listIds;

    if (data != null) {
      await fetchSubcategoryIds(data).then((result) {
        listIds = result;
      });
    }
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: AddEditCategoryOverlay(
            onClose: () {
              Navigator.of(context).pop();
            },
            fetchData: fetchData,
            data: data,
            subcategories: productSubcategories,
            listIds: listIds,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: Card(
          elevation: 10.0,
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
                      'Categories settings',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(Icons.add),
                        label: "Add new category"),
                  ],
                ),
                const SizedBox(height: 16.0),
                productCategories != null
                    ? table()
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
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: tableHead('Category name'),
            ),
            Align(alignment: Alignment.center, child: tableHead('Photo')),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: tableHead('Actions'),
                )),
          ],
        ),
        for (var category in productCategories!)
          TableRow(
            children: [
              tableCell(category['name']),
              tableCellPhoto(category['photo']['data']),
              tableActions(category)
            ],
          ),
      ],
    );
  }

  TableCell tableCell(String data) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30),
        child: Text(
          data,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'GilroyLight',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  TableCell tableCellPhoto(String data) {
    return TableCell(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0.0),
            child: Image.memory(
              base64.decode(data.toString()),
              height: 25,
            )));
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                onPressed: () {
                  showAddEditMenu(context, data: data);
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
                        content:
                            'Are you sure you want to delete this product category?',
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deleteCategory(data['id']);
                        },
                        onNoPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                icon: Icons.delete_outline_outlined,
                iconColor: AppColors.errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableCell tableHead(String header) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(
          header,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class AddEditCategoryOverlay extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;
  final Map<String, dynamic>? data;
  final List<Map<String, dynamic>>? subcategories;
  List<int>? listIds;

  AddEditCategoryOverlay(
      {Key? key,
      required this.onClose,
      required this.fetchData,
      this.data,
      this.subcategories,
      this.listIds})
      : super(key: key);

  @override
  _AddEditCategoryOverlayState createState() => _AddEditCategoryOverlayState();
}

class _AddEditCategoryOverlayState extends State<AddEditCategoryOverlay> {
  late List<bool> isCheckedList =
      List.generate(widget.subcategories!.length, (index) => false);
  final ImagePicker _imagePicker = ImagePicker();
  List<int> listIds = [];

  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = widget.data!;
    }
    if (widget.listIds != null) {
      isCheckedList = List.generate(
          widget.subcategories!.length,
          (index) => widget.data != null && widget.listIds != null
              ? widget.listIds!.contains(widget.subcategories![index]['id'])
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
      widget.listIds ??= [];
      data['addedIds'] = listIds;
      final response = await ProductCategoriesService().post("", data);
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

  Future<void> editCategory() async {
    try {
      widget.listIds ??= [];
      List<int> addedValues = listIds
          .where((element) => !widget.listIds!.contains(element))
          .toList();
      List<int> removedValues = widget.listIds!
          .where((element) => !listIds.contains(element))
          .toList();
      widget.data!['addedIds'] = addedValues;
      widget.data!['removedIds'] = removedValues;
      final response = await ProductCategoriesService().put("", widget.data);
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
      child: Container(
        width: 400,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Card(
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
                      fontFamily: 'GilroyLight',
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
                          child: Column(
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
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: AppColors.dimWhite,
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
                                        iconColor: AppColors.primaryColor,
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
                                          widget.subcategories!.length,
                                          (index) => Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Checkbox(
                                                activeColor:
                                                    AppColors.primaryColor,
                                                value: isCheckedList[index],
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    setState(() {
                                                      isCheckedList[index] =
                                                          value!;
                                                      if (value) {
                                                        listIds.add(widget
                                                                .subcategories![
                                                            index]['id']);
                                                      } else {
                                                        listIds.remove(widget
                                                                .subcategories![
                                                            index]['id']);
                                                      }
                                                    });
                                                  });
                                                },
                                              ),
                                              Text(widget.subcategories![index]
                                                  ['name']),
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
                                  onPressed: () {
                                    widget.data != null
                                        ? editCategory()
                                        : addCategory();
                                  },
                                  width: double.infinity,
                                  label: widget.data != null ? 'Edit' : "Add")
                            ],
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
                color: false ? AppColors.errorColor : Colors.black,
                fontFamily: 'GilroyLight'),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                filled: true,
                fillColor: false ? AppColors.dimError : AppColors.dimWhite,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color:
                          false ? AppColors.errorColor : AppColors.primaryColor,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
