import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/constants.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final String? initialValue;
  final MyVoidCallback onChanged;

  const InputField({
    Key? key,
    required this.label,
    this.isObscure = false,
    required this.onChanged,  this.initialValue,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
          height: 49,
          child: TextFormField(
            onChanged: (value) {
             widget.onChanged(value);
            },
            initialValue: widget.initialValue,
            style: const TextStyle(color: Colors.black),
            obscureText: widget.isObscure,
            decoration: InputDecoration(
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
