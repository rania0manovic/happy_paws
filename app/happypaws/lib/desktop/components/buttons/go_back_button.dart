import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pop(),
      child: const Row(
        children: [
          Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.primary,
            size: 16,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Go back',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          )
        ],
      ),
    );
  }
}
