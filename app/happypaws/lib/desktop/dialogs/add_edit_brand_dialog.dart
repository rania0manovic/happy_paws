import 'package:flutter/material.dart';
import 'package:happypaws/common/services/BrandsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';

class AddEditBrandMenu extends StatefulWidget {
  final VoidCallback onClose;
   final MyVoidCallback onAdd;
  final MyVoidCallback onEdit;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? allBrands;

  const AddEditBrandMenu({
    Key? key,
    required this.onClose,
    this.data,
    this.allBrands, required this.onAdd, required this.onEdit,
  }) : super(key: key);

  @override
  _AddEditBrandMenuState createState() => _AddEditBrandMenuState();
}

class _AddEditBrandMenuState extends State<AddEditBrandMenu> {
  final _formKey = GlobalKey<FormState>();
  bool disabledButton = false;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = {...widget.data!};
    }
  }

  Future<void> addBrand() async {
    try {
      setState(() {
        disabledButton = true;
      });
      final response = await BrandsService().post("", data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.onAdd(response.data);
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully added a new brand");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully added a new allergy for the selected pet!");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editBrand() async {
    try {
      setState(() {
        disabledButton = true;
      });
      final response = await BrandsService().put("", data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.onEdit(response.data);
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully edited selected brand");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully added a new allergy for the selected pet!");
      }
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
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
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputField(
                            label: "Name:",
                            value: data['name'],
                            onChanged: (value) => setState(() {
                              data['name'] = value;
                            }),
                            customValidation: () {
                              if (widget.allBrands != null) {
                                bool hasSameName = widget.allBrands!['items']
                                        .any((brand) =>
                                            brand['name'] == data['name']) ??
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
                                'Brand with the same name already exists or no changes have been detected!',
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          PrimaryButton(
                              isDisabled: disabledButton,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  widget.data != null
                                      ? editBrand()
                                      : addBrand();
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
    );
  }
}
