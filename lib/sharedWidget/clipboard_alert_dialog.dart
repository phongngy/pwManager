import 'package:flutter/material.dart';

class ClipboardAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Zwischenablage löschen',
      ),
      content: const Text('Vergessen Sie nicht die Zwischenablage zu leeren.'),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
