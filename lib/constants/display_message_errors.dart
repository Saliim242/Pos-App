import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackBars(
    {required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        titleFontSize: 14,
        messageFontSize: 13,
      ),
    ),
  );
}
