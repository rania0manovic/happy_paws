import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';

class PrimaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;

  PrimaryIconButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.all(15),
      ),
      label: Text(label),
    );
  }
}
