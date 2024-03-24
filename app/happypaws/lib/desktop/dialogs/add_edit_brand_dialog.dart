import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/BrandsService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';

class AddEditBrandMenu extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;

  final Map<String, dynamic>? data;

  const AddEditBrandMenu({
    Key? key,
    required this.onClose,
    required this.fetchData,
    this.data,
  }) : super(key: key);

  @override
  _AddEditBrandMenuState createState() => _AddEditBrandMenuState();
}

class _AddEditBrandMenuState extends State<AddEditBrandMenu> {
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = widget.data!;
    }
  }

  Future<void> addBrand() async {
    try {
      final response = await BrandsService().post("", data);
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

  Future<void> editBrand() async {
    try {
      final response = await BrandsService().put("", widget.data);
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
    return SizedBox(
      width: 370,
      height: 230,
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
                  widget.data != null ? 'Edit brand' : "Add new brand",
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
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: SingleChildScrollView(
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
                          height: 32,
                        ),
                        PrimaryButton(
                            onPressed: () {
                              widget.data != null ? editBrand() : addBrand();
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
