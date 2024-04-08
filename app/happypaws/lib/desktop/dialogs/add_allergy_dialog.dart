import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/PetAllergiesService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
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
      data["petId"] = widget.petId;
      var response = await PetAllergiesService().post('', data);
      if (response.statusCode == 200) {
        widget.onAdd(response.data);
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully added a new allergy for the selected pet!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editAllergyForPatient() async {
    try {
      var response = await PetAllergiesService().put('', data);
      if (response.statusCode == 200) {
        widget.onEdit(response.data);
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully edited the allergy information!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
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
          Expanded(
            child: Column(
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
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedSeverity,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.grey),
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
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Expanded(child: SizedBox()),
                PrimaryButton(
                  onPressed: () {
                    widget.data == null
                        ? addAllergyForPatient()
                        : editAllergyForPatient();
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
            ),
          )
        ],
      ),
    );
  }
}