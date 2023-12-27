import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double? width;

  PrimaryButton({
    required this.onPressed,
    required this.label,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.all(15),
        ),
        child: Text(label),
      ),
    );
  }
}
