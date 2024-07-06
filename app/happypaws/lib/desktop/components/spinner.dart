import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/regular_text.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class Spinner extends StatelessWidget {
  const Spinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
          SizedBox(
            height: 16,
          ),
          RegularText(
            label: "Please wait...",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          )
        ],
      ),
    );
  }
}
