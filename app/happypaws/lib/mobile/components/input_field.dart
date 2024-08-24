import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final String? initialValue;
  final MyVoidCallback onChanged;
  final bool isRequired;
  final bool isNumber;
  final bool enabled;

  const InputField(
      {Key? key,
      required this.label,
      this.isObscure = false,
      required this.onChanged,
      this.initialValue,
      this.isRequired = true,
      this.isNumber = false,
      this.enabled=true})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isErrorShowing = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: isErrorShowing ? 75 : 50,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              widget.onChanged(value);
            },
            validator: (value) {
              if (!widget.isRequired) {
                return null;
              }
              if (value == null || value.isEmpty) {
                setState(() {
                  isErrorShowing = true;
                });
                return "This field is required";
              }
              if (widget.isNumber) {
                if (double.tryParse(value) == null) {
                  setState(() {
                    isErrorShowing = true;
                  });
                  return "Input must be numerical value (e.g. 5.5)";
                }
              }
              setState(() {
                isErrorShowing = false;
              });
              return null;
            },
            enabled: widget.enabled,
            initialValue: widget.initialValue,
            style:  TextStyle(color: widget.enabled ? Colors.black : AppColors.gray, fontSize: 16, fontWeight: FontWeight.w500),
            obscureText: widget.isObscure,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: AppColors.error, fontSize: 14),
              filled: true,
              fillColor: AppColors.dimWhite,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
