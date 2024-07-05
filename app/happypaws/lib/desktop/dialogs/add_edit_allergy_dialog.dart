import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/PetAllergiesService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';

class AddAllergyMenu extends StatefulWidget {
  final VoidCallback onClosed;
  final MyVoidCallback onAdd;
  final MyVoidCallback onEdit;
  final MyVoidCallback onRemove;
  final int petId;
  final Map<String, dynamic>? data;

  const AddAllergyMenu(
      {super.key,
      required this.onClosed,
      required this.petId,
      this.data,
      required this.onAdd,
      required this.onEdit,
      required this.onRemove});

  @override
  State<AddAllergyMenu> createState() => _AddAllergyMenuState();
}

class _AddAllergyMenuState extends State<AddAllergyMenu> {
  Map<String, dynamic> data = {};
  String selectedSeverity = "Mild";
  bool disabledButton = false;

  @override
  initState() {
    super.initState();
    if (widget.data != null) {
      selectedSeverity = widget.data!['allergySeverity'];
      data = widget.data!;
    }
  }

  Future<void> addAllergyForPatient() async {
    try {
      setState(() {
        disabledButton = true;
      });
      data["petId"] = widget.petId;
      var response = await PetAllergiesService().post('', data);
      if (response.statusCode == 200) {
        widget.onAdd(response.data);
        widget.onClosed();
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully added a new allergy for the selected pet!");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      }
      rethrow;
    }
  }

  Future<void> editAllergyForPatient() async {
    try {
      setState(() {
        disabledButton = true;
      });
      var response = await PetAllergiesService().put('', data);
      if (response.statusCode == 200) {
        widget.onEdit(response.data);
        widget.onClosed();
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully edited the allergy information!");
      } else {
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "An error occured! Please try again later.");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      }
      rethrow;
    }
  }

  Future<void> deleteAllergyForPatient() async {
    try {
      var response = await PetAllergiesService().delete(
        '/${widget.data!['id']}',
      );
      if (response.statusCode == 200) {
        widget.onRemove(widget.data!['id']);
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully deleted the selected allergy!");
      } else {
        throw Exception('Error occured');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      }
      rethrow;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const IconButton(
                    icon: Icon(Icons.inventory_2_outlined),
                    onPressed: null,
                    color: AppColors.gray,
                  ),
                  const Text(
                    "Add new allergy",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: widget.onClosed,
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                  ),
                ],
              ),
              InputField(
                label: "Allergen:",
                value: widget.data != null ? widget.data!['name'] : '',
                onChanged: (value) => setState(() {
                  data['name'] = value;
                }),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const LightText(
                    label: 'Severity:',
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: selectedSeverity,
                      decoration: const InputDecoration(
                        errorStyle:
                            TextStyle(color: AppColors.error, fontSize: 14),
                        fillColor: AppColors.fill,
                        filled: true,
                        border: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      icon:
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSeverity = newValue!;
                          data['allergySeverity'] = newValue;
                        });
                      },
                      items: <String>[
                        'Mild',
                        'Moderate',
                        'Severe',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  PrimaryButton(
                    isDisabled: disabledButton,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.data == null
                            ? addAllergyForPatient()
                            : editAllergyForPatient();
                      }
                    },
                    label: widget.data == null ? "Add" : 'Edit',
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                      visible: widget.data != null,
                      child: PrimaryButton(
                        onPressed: () {
                          deleteAllergyForPatient();
                        },
                        label: "Delete",
                        backgroundColor: AppColors.error,
                        width: double.infinity,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
