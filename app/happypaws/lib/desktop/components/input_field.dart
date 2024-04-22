import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final void Function(String value)? onChanged;
  final String? value;
  final Color? fillColor;

  const InputField(
      {Key? key,
      required this.label,
      this.isObscure = false,
      this.onChanged,
      this.value,
      this.fillColor = const Color.fromARGB(117, 255, 255, 255)})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: TextFormField(
            initialValue: widget.value,
            onChanged: (newValue) {
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            style: const TextStyle(
              color: Colors.black,
            ),
            obscureText: widget.isObscure,
            decoration: InputDecoration(
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
