import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final void Function(String value)? onChanged;
  final String? value;
  final Color? fillColor;
  final Color labelColor;
  final bool isRequired;
  final bool isNumber;
  final BoolValidation? customValidation;
  final String? customMessage;

  const InputField(
      {Key? key,
      required this.label,
      this.isObscure = false,
      this.onChanged,
      this.value,
      this.fillColor = AppColors.fill,
      this.isRequired = true,
      this.isNumber = false,
      this.customValidation,
      this.customMessage,
      this.labelColor = Colors.black})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isErrorShowing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        LightText(
          label: widget.label,
          fontSize: 14,
          color: widget.labelColor,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            initialValue: widget.value,
            onChanged: (newValue) {
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            validator: (value) {
              if (!widget.isRequired) {
                return null;
              }
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              if (widget.isNumber) {
                if (double.tryParse(value) == null) {
                  return "Input must be numerical value (e.g. 5.5)";
                }
              }
              if (widget.customValidation != null &&
                  widget.customValidation!() == false) {
                return widget.customMessage!;
              }

              return null;
            },
            style: const TextStyle(
              color: Colors.black,
            ),
            obscureText: widget.isObscure,
            decoration: InputDecoration(
                errorMaxLines: 3,
                errorStyle:
                    const TextStyle(color: AppColors.error, fontSize: 14),
                contentPadding:
                    const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                filled: true,
                fillColor: widget.fillColor,
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
