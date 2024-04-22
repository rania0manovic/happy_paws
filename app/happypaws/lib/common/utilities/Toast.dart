import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class ToastHelper {
  static final FToast _fToast = FToast();

  static void _showToast(BuildContext context, String message, Color backgroundColor, IconData icon) {
    _fToast.init(context);
    
    _fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 12.0),
            Flexible( 
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.visible, 
          ),
        ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 5),
    );
  }

  static void showToastSuccess(BuildContext context, String message) {
    _showToast(context, message, AppColors.success, Icons.check);
  }

  static void showToastError(BuildContext context, String message) {
    _showToast(context, message, AppColors.error, Icons.error_outlined);
  }
    static void showToastWarning(BuildContext context, String message) {
    _showToast(context, message, AppColors.info, Icons.info_outline);
  }
}
