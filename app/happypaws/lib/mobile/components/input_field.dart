import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final String? initialValue;
  final MyVoidCallback onChanged;
  final bool isRequired;

  const InputField({
    Key? key,
    required this.label,
    this.isObscure = false,
    required this.onChanged,
    this.initialValue,
    this.isRequired = true,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
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
              setState(() {
                isErrorShowing = false;
              });
              return null;
            },
            initialValue: widget.initialValue,
            style: const TextStyle(color: Colors.black),
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
