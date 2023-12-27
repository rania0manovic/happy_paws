import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/BrandsService.dart';
import 'package:happypaws/common/services/ProductCategoriesService.dart';
import 'package:happypaws/common/services/ProductSubcategoriesService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/ActionButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryIconButton.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, dynamic>>? productCategories;
  List<Map<String, dynamic>>? productSubcategories;
  List<Map<String, dynamic>>? productBrands;

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
    var responseBrands = await BrandsService().getPaged("", 1, 999);
    if (responseBrands.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseBrands.body);
      setState(() {
        responseBrands = List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
  }

  void showAddEditProductMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 100, horizontal: 200),
          contentPadding: const EdgeInsets.all(8),
          content: AddEditBrandOverlay(
            onClose: () {
              Navigator.of(context).pop(); 
            },
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
                      'Product details',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditProductMenu(context),
                        icon: const Icon(Icons.add),
                        label: "Add new product"),
                  ],
                ),
                const SizedBox(height: 16.0),
                table()
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
            tableHead('Item Code.'),
            tableHead('Photo'),
            tableHead('Item name'),
            tableHead('Item category'),
            tableHead('Item subcategory'),
            tableHead('Inventory'),
            tableHead('Actions'),
          ],
        ),
        TableRow(
          children: [
            tableCell("Test"),
            tableCellPhoto("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableActions()
          ],
        ),
        TableRow(
          children: [
            tableCell("Test"),
            tableCellPhoto("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableActions()
          ],
        ),
        TableRow(
          children: [
            tableCell("Test"),
            tableCellPhoto("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableActions()
          ],
        ),
        TableRow(
          children: [
            tableCell("Test"),
            tableCellPhoto("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableCell("Test"),
            tableActions()
          ],
        ),
      ],
    );
  }

  TableCell tableCell(String data) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
            child: Text(
          data,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'GilroyLight',
              fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  TableCell tableCellPhoto(String data) {
    return const TableCell(
        child: Padding(
      padding: EdgeInsets.only(top: 0, bottom: 0.0),
      child: Image(
        image: AssetImage("assets/images/sample_dog_food.jpg"),
        height: 25,
      ),
    ));
  }

  TableCell tableActions() {
    return TableCell(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SvgPicture.asset(
                "assets/icons/edit (2).svg",
                height: 18,
                color: AppColors.gray,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SvgPicture.asset(
                "assets/icons/delete.svg",
                height: 18,
                color: AppColors.errorColor,
              ),
            )
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
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class AddEditBrandOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const AddEditBrandOverlay({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  @override
  _AddEditBrandOverlayState createState() => _AddEditBrandOverlayState();
}

class _AddEditBrandOverlayState extends State<AddEditBrandOverlay> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedBrand;
  Map<String, dynamic> data = {};
  List<Map<String, dynamic>>? productCategories;
  List<Map<String, dynamic>>? productSubcategories;
  List<Map<String, dynamic>>? productBrands;

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
    var responseBrands = await BrandsService().getPaged("", 1, 999);
    if (responseBrands.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseBrands.body);
      setState(() {
        productBrands = List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: (productCategories == null ||
              productBrands == null ||
              productSubcategories == null)
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
                    const Text(
                      "Add new product",
                      style: TextStyle(
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
                                  (String? newValue) => setState(() {
                                        selectedCategory = newValue;
                                      }),
                                  selectedCategory),
                              dropdownMenu(
                                  productSubcategories!,
                                  "Subcategory",
                                  (String? newValue) => setState(() {
                                        selectedSubCategory = newValue;
                                      }),
                                  selectedSubCategory),
                              dropdownMenu(
                                  productBrands!,
                                  "Brand",
                                  (String? newValue) => setState(() {
                                        selectedBrand = newValue;
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
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: AppColors.dimWhite,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/gallery.png")),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 0,
                                      child: ActionButton(
                                          onPressed: () {}, icon: Icons.add))
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              PrimaryButton(
                                onPressed: () {},
                                label: "Add product",
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
      void Function(String? newValue) onChanged, String? selectedCategory) {
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
                  value: selectedCategory,
                  hint: const Text('Select'),
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: onChanged,
                  items: [
                    for (var item in items)
                      DropdownMenuItem<String>(
                        value: item['name'],
                        child: Text(item['name']),
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
          child: TextField(
            minLines: 10,
            maxLines: 10,
            style: const TextStyle(
                fontFamily: 'GilroyLight',
                fontWeight: FontWeight.w300,
                fontSize: 14),
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
          child: TextField(
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
