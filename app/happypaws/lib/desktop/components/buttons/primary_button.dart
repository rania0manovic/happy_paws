import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double fontSize;
  final Color backgroundColor;
  final bool isDisabled;
  final bool disabledWithoutSpinner;

  const PrimaryButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.width,
      this.fontSize = 14,
      this.backgroundColor = AppColors.primary,
      this.isDisabled = false,
      this.disabledWithoutSpinner = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isDisabled || disabledWithoutSpinner ? null : onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.primaryMediumLight,
          backgroundColor:
              isDisabled ? backgroundColor.withOpacity(0.5) : backgroundColor,
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            label,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          if (isDisabled)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryLight,
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
