import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  final String label;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;

  const RegularText(
      {super.key,
      required this.label,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 16,  this.color= Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:
          TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color),
    );
  }
}
