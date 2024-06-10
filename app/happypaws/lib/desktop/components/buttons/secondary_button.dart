import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final double? width;
  final double? height;


  const SecondaryButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label,
      this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppColors.primary,
        ),
        style: ButtonStyle(
          alignment: Alignment.center,
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(color: AppColors.primary)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return const Color.fromARGB(18, 51, 10, 78);
              }
              return Colors.transparent;
            },
          ),
        ),
        label: Text(
          label,
          style: const TextStyle(color: AppColors.primary),
        ),
      ),
    );
  }
}
