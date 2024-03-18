import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';

class PrimaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final double? width;

  final double fontSize;

  const PrimaryIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label,
      this.fontSize = 14,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), 
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
