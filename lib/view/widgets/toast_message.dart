import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void toastMessage({
  required String text,
  required BuildContext context,
  Color? bgColor,
}) async {
  showToast(text,
      context: context,
      backgroundColor: bgColor ?? Color.fromARGB(255, 255, 230, 0),
      textStyle: TextStyle(color: Colors.black),
      duration: const Duration(seconds: 2),
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade);
}
