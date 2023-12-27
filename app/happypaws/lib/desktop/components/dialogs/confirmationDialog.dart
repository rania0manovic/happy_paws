import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  ConfirmationDialog({
    required this.title,
    required this.content,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: AppColors.primaryColor),
      ),
      content: Text(content),
      actions: [
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primaryColor.withOpacity(0.1);
              }
              return Colors.transparent;
            },
          )),
          onPressed: onYesPressed,
          child: Text('Yes', style: TextStyle(color: AppColors.primaryColor)),
        ),
        TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primaryColor.withOpacity(0.1);
              }
              return Colors.transparent;
            },
          )),
          onPressed: onNoPressed,
          child: Text('No', style: TextStyle(color: AppColors.primaryColor)),
        ),
      ],
    );
  }
}
