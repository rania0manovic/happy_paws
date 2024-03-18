import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double? width;
  final double fontSize;


  const PrimaryButton({super.key, 
    required this.onPressed,
    required this.label,
    this.width, 
    this.fontSize=14,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), 
          ),
        ),
        child: Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.white),),
      ),
    );
  }
}
