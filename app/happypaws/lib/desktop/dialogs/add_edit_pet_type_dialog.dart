import 'package:flutter/material.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';

class AddEditPetTypeMenu extends StatefulWidget {
  final VoidCallback onClose;
  final MyVoidCallback onAdd;
  final MyVoidCallback onEdit;
  final Map<String, dynamic>? allPetTypes;
  final Map<String, dynamic>? data;

  const AddEditPetTypeMenu({
    Key? key,
    required this.onClose,
    this.data,
    this.allPetTypes, required this.onAdd, required this.onEdit,
  }) : super(key: key);

  @override
  _AddEditPetTypeMenuState createState() => _AddEditPetTypeMenuState();
}

class _AddEditPetTypeMenuState extends State<AddEditPetTypeMenu> {
  final _formKey = GlobalKey<FormState>();
  bool disabledButton = false;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = {...widget.data!};
    }
  }

  Future<void> addPetType() async {
    try {
      setState(() {
        disabledButton = true;
      });
      final response = await PetTypesService().post("", data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.onAdd(response.data);
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully added a new pet type!");
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

  Future<void> editPetType() async {
    try {
      setState(() {
          disabledButton = true;
        });
      final response = await PetTypesService().put("", data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onClose();
        widget.onEdit(response.data);
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully edited the selected pet type!");
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
    return SizedBox(
      width: 370,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
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
                    widget.data != null ? 'Edit pet type' : "Add new pet type",
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
                          InputField(
                            label: "Type name:",
                            customValidation: () {
                                    if (widget.allPetTypes != null) {
                                      bool hasSameName = widget
                                              .allPetTypes!['items']
                                              .any((category) =>
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
                                      'Pet type with the same name already exists or no changes have been detected!',
                            value:
                                widget.data != null ? widget.data!['name'] : '',
                            onChanged: (value) => setState(() {
                              data['name'] = value;
                            }),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          PrimaryButton(
                            isDisabled: disabledButton,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  widget.data != null
                                      ? editPetType()
                                      : addPetType();
                                }
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
      ),
    );
  }
}
