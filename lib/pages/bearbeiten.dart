import 'package:flutter/material.dart';
import 'package:pwsafe/klassen/passwort.dart';
import 'package:pwsafe/pages/formular_beabeiten.dart';

class BearbeitenPW extends StatelessWidget {
  final Passwort pw;
  const BearbeitenPW({Key? key, required this.pw}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Passwort hinzufuegen"),
        ),
        body: Center(
            child: FormularBearbeiten(
          pw: pw,
        )));
  }
}
