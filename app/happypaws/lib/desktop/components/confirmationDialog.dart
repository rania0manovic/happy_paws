import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;
  final double insentPaddingY;
  final double insentPaddingX;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onYesPressed,
    required this.onNoPressed,
    this.insentPaddingX = 0,
    this.insentPaddingY = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: insentPaddingY, horizontal: insentPaddingX),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.primary),
      ),
      content: Text(content),
      actions: [
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primary.withOpacity(0.1);
              }
              return Colors.transparent;
            },
          )),
          onPressed: onYesPressed,
          child: const Text('Yes', style: TextStyle(color: AppColors.primary)),
        ),
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primary.withOpacity(0.1);
              }
              return Colors.transparent;
            },
          )),
          onPressed: onNoPressed,
          child: const Text('No', style: TextStyle(color: AppColors.primary)),
        ),
      ],
    );
  }
}
