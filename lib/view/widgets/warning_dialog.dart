import 'package:flutter/material.dart';

Future<void> warningDialog({
  required BuildContext context,
  required String content,
  required VoidCallback onYesPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Warning',
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: onYesPressed,
            child: Text(
              "Yes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
