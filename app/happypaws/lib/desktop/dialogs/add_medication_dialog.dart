import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/PetMedicationsService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/buttons/secondary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddMedicationMenu extends StatefulWidget {
  final VoidCallback onClosed;
  final MyVoidCallback onAdd;
  final MyVoidCallback onEdit;
  final MyVoidCallback onRemove;


  final int petId;
  final Map<String, dynamic>? data;

  const AddMedicationMenu(
      {super.key, required this.onClosed, required this.petId, this.data, required this.onRemove, required this.onAdd, required this.onEdit, });

  @override
  State<AddMedicationMenu> createState() => _AddMedicationMenuState();
}

class _AddMedicationMenuState extends State<AddMedicationMenu> {
  Map<String, dynamic> data = {};
  String selectedSeverity = "Mild";
  String selectedDate = 'Select date';

  @override
  initState() {
    super.initState();
    if (widget.data != null) {
      selectedDate = DateFormat('dd.MM.yyyy')
          .format(DateTime.parse(widget.data!['until']));
      data = widget.data!;
    }
  }

  Future<void> addMedicationForPatient() async {
    try {
      data["petId"] = widget.petId;
      var response = await PetMedicationsService().post('', data);
      if (response.statusCode == 200) {
        widget.onAdd(response.data);
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully added a new medication for the selected pet!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editMedicationForPatient() async {
    try {
      var response = await PetMedicationsService().put('', data);
      if (response.statusCode == 200) {
        widget.onEdit(response.data);
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully edited the medication information!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMedicationForPatient() async {
    try {
      var response = await PetMedicationsService().delete(
        '/${widget.data!['id']}',
      );
      if (response.statusCode == 200) {
        widget.onRemove(widget.data!['id']);
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully deleted the selected medication!");
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
                "Add new medication",
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
            label: "Medication name:",
            value: widget.data != null ? widget.data!['medicationName'] : '',
            onChanged: (value) => setState(() {
              data['medicationName'] = value;
            }),
          ),
          InputField(
            label: "Dosage (mg):",
            value: widget.data != null ? widget.data!['dosage'].toString() : '',
            onChanged: (value) => setState(() {
              data['dosage'] = value;
            }),
          ),
          InputField(
            label: "Dosage frequency (every N hours):",
            value: widget.data != null
                ? widget.data!['dosageFrequency'].toString()
                : '',
            onChanged: (value) => setState(() {
              data['dosageFrequency'] = value;
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
                  label: 'Until:',
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        height: 40,
                        icon: Icons.date_range_rounded,
                        label: selectedDate,
                        width: double.infinity,
                        onPressed: () {
                          _showDatePicker(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Expanded(child: SizedBox()),
                PrimaryButton(
                  onPressed: () {
                    widget.data == null
                        ? addMedicationForPatient()
                        : editMedicationForPatient();
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
                        deleteMedicationForPatient();
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

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width / 3,
            child: SfDateRangePicker(
              minDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                final formatter = DateFormat('dd.MM.yyyy');
                final value = formatter.format(args.value!);
                setState(() {
                  selectedDate = value;
                  data['until'] = args.value!.toIso8601String();
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}
