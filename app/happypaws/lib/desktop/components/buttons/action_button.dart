import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isRounded;
  final Color color;
  final Color iconColor;
  final double iconSize;


  const ActionButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.isRounded = false,
      this.color = Colors.transparent,
      this.iconColor = Colors.white,
      this.iconSize=16});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: iconSize,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
              return color;
          },
        ),
      ),
      splashRadius: 15,
      padding: const EdgeInsets.all(0),
      icon: Icon(icon, color: iconColor),
    );
  }
}
