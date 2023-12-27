import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.primaryColor,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color:AppColors.primaryColor)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return const Color.fromARGB(18, 51, 10, 78);
            }
            return Colors.transparent; 
          },
        ),
      ),
      label: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          label,
          style: const TextStyle(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
