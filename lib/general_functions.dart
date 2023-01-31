import 'package:flutter/material.dart';

void showLoading(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text(text), CircularProgressIndicator()],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(BuildContext context, String message, Function posAction,
    String posActionText,
    {Function? negAction, String? negActionText}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  posAction(context);
                },
                child: Text(posActionText))
          ],
        );
      });
}
