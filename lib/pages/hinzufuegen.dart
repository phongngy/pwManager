import 'package:flutter/material.dart';
import 'package:pwsafe/pages/formular.dart';

class AddPW extends StatelessWidget {
  const AddPW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Passwort hinzufuegen"),
        ),
        body: const Center(child: Formular()));
  }
}
