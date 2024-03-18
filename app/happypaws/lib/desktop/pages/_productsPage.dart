import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:happypaws/common/services/ImagesService.dart';
import 'package:happypaws/desktop/components/dialogs/confirmationDialog.dart';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/BrandsService.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/ActionButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryIconButton.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, dynamic>>? products;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var responseProducts = await ProductsService().getPaged("", 1, 999);
    if (responseProducts.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseProducts.body);
      setState(() {
        products = List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
  }

  void showAddEditProductMenu(BuildContext context,
      {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 100, horizontal: 200),
          contentPadding: const EdgeInsets.all(8),
          content: AddEditProductMenu(
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

  Future<void> deleteProduct(int id) async {
    try {
      var response = await ProductsService().delete('/$id');
      if (response.statusCode == 200) {
        fetchData();
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
                      'Product details',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditProductMenu(context),
                        icon: const Icon(Icons.add, color: Colors.white,),
                        label: "Add new product"),
                  ],
                ),
                const SizedBox(height: 16.0),
                products != null
                    ? (products!.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Text(
                              'No products added yet.',
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
            tableHead('Item Id.'),
            tableHead('Photo'),
            tableHead('Item name'),
            tableHead('Item category'),
            tableHead('Item subcategory'),
            tableHead('Inventory'),
            tableHead('Actions'),
          ],
        ),
        for (var product in products!)
          TableRow(
            children: [
              tableCell(product['id'].toString()),
              tableCellPhoto(product['productImages'][0]['image']['data']),
              tableCell(product['name']),
              tableCell(product['productCategorySubcategory']['productCategory']
                  ['name']),
              tableCell(product['productCategorySubcategory']
                  ['productSubcategory']['name']),
              tableCell(product['inStock'].toString()),
              tableActions(product)
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
            data.length > 20 ? '${data.substring(0, 20)}...' : data,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )),
      ),
    );
  }

  TableCell tableCellPhoto(String data) {
    return TableCell(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0.0),
            child: Image.memory(
              base64.decode(data.toString()),
              height: 30,
            )));
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              onPressed: () {
                showAddEditProductMenu(context, data: data);
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
                      content: 'Are you sure you want to delete this product?',
                      onYesPressed: () {
                        Navigator.of(context).pop();
                        deleteProduct(data['id']);
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

class AddEditProductMenu extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;
  final Map<String, dynamic>? data;

  const AddEditProductMenu({
    Key? key,
    required this.onClose,
    required this.fetchData,
    this.data,
  }) : super(key: key);

  @override
  _AddEditProductMenuState createState() => _AddEditProductMenuState();
}

class _AddEditProductMenuState extends State<AddEditProductMenu> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedBrand;
  List<Map<String, dynamic>>? productCategories;
  List<Map<String, dynamic>>? productSubcategories;
  List<Map<String, dynamic>>? productBrands;
  final ImagePicker _imagePicker = ImagePicker();
  final List<File> _selectedImages = [];
  List<Map<String, dynamic>> productImages = [];
  int activeImageId = 0;
  int activeImageIndex = 0;

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
      Map<String, dynamic> jsonData = json.decode(responseCategories.body);
      setState(() {
        productCategories = List<Map<String, dynamic>>.from(jsonData['items']);
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
      Map<String, dynamic> jsonData = json.decode(responseBrands.body);
      setState(() {
        productBrands = List<Map<String, dynamic>>.from(jsonData['items']);
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
      List<Map<String, dynamic>> jsonData =
          (json.decode(responseSubcategories.body) as List)
              .cast<Map<String, dynamic>>();
      setState(() {
        productSubcategories = jsonData;
      });
    }
  }

  Future<void> _pickImage() async {
    if (productImages.length >= 6) return;
    final XFile? selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      List<int> bytes = await File(selectedImage.path).readAsBytes();
      String base64Image = base64Encode(bytes);
      setState(() {
        _selectedImages.add(File(selectedImage.path));
        dynamic photo = {
          'image': {'data': base64Image}
        };
        productImages.add(photo);
      });
    }
  }

  Future<void> addProduct() async {
    try {
      data["imageFiles"] = _selectedImages;
      var response = await ProductsService().post('', data);
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

  Future<void> editProduct() async {
    try {
      data["imageFiles"] = _selectedImages;
      var response = await ProductsService().put('', widget.data);
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

  Future<void> deleteImage() async {
    try {
      if (activeImageId != 0) {
        var response = await ImagesService().delete('/$activeImageId');
        if (response.statusCode == 200) {
          widget.fetchData();
        }
      }
      setState(() {
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
                      widget.data != null ? "Edit product" : "Add new product",
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
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
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
                              inputField("Name", "name"),
                              inputField("Price", "price"),
                              textBox("Description", "description"),
                            ],
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              inputField("In Stock", "inStock"),
                              dropdownMenu(
                                  productCategories!,
                                  "Category",
                                  (String? newValue) async {
                                        setState(() {
                                          selectedSubCategory = null;
                                          selectedCategory = null;
                                        });
                                        await fetchSubcategories(newValue);
                                        setState(() {
                                          selectedCategory = newValue;
                                        });
                                      },
                                  selectedCategory),
                              dropdownMenu(
                                  productSubcategories == null
                                      ? List.empty()
                                      : productSubcategories!,
                                  "Subcategory",
                                  (String? newValue) => setState(() {
                                        selectedSubCategory = newValue;
                                        data['productCategorySubcategoryId'] =
                                            newValue;
                                      }),
                                  selectedSubCategory,
                                  isDisabeled:
                                      selectedCategory == null ? true : false),
                              dropdownMenu(
                                  productBrands!,
                                  "Brand",
                                  (String? newValue) => setState(() {
                                        selectedBrand = newValue;
                                        data['brandId'] = newValue;
                                      }),
                                  selectedBrand)
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
                                    color: AppColors.dimWhite,
                                    borderRadius: BorderRadius.circular(10)),
                                child: productImages.isNotEmpty
                                    ? Stack(children: [
                                        Swiper(
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(32.0),
                                              child: Image.memory(
                                                base64.decode(
                                                    productImages[index]
                                                            ['image']['data']
                                                        .toString()),
                                              ),
                                            );
                                          },
                                          onIndexChanged: (value) =>
                                              setState(() {
                                            if (productImages[value]['image']
                                                    ['id'] !=
                                                null) {
                                              activeImageId =
                                                  productImages[value]['image']
                                                      ['id'];
                                            } else {
                                              activeImageId = 0;
                                            }
                                            activeImageIndex = value;
                                          }),
                                          itemCount: productImages.length,
                                          pagination: const SwiperPagination(
                                            builder: DotSwiperPaginationBuilder(
                                              activeColor: AppColors.primary,
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
                                              iconColor: AppColors.primary,
                                            )),
                                        Positioned(
                                            bottom: 0,
                                            right: 20,
                                            child: ActionButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ConfirmationDialog(
                                                      title: 'Confirmation',
                                                      content:
                                                          'Are you sure you want to delete this photo? This action cannot be undone and will take place immediatly.',
                                                      onYesPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        deleteImage();
                                                      },
                                                      onNoPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              icon:
                                                  Icons.delete_forever_rounded,
                                              iconSize: 20,
                                              iconColor: AppColors.error,
                                            ))
                                      ])
                                    : ActionButton(
                                        onPressed: _pickImage,
                                        icon: Icons.add,
                                        iconSize: 20,
                                        iconColor: AppColors.primary,
                                      ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              PrimaryButton(
                                onPressed: () => widget.data != null
                                    ? editProduct()
                                    : addProduct(),
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
    );
  }

  Column dropdownMenu(List<Map<String, dynamic>> items, String label,
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
            width: 300,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedOption,
                  hint: const Text('Select'),
                  underline: Container(),
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
                filled: true,
                fillColor: const Color(0xfff2f2f2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff3F0D84),
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
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
              color: false ? AppColors.error : Colors.black,
            ),
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
                      color: false ? AppColors.error : AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
