import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pwsafe/klassen/passwort.dart';
import 'package:pwsafe/pages/bearbeiten.dart';

Widget PWListTile(
    {required Passwort pwObjekt,
    required String titel,
    required BuildContext context,
    required farbe}) {
  return Container(
    color: farbe,
    child: ListTile(
      title: Text(titel),
      subtitle: Text(pwObjekt.benutzername),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: pwObjekt.benutzername));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Benutzername gespeichert")));
              },
              icon: const Icon(Icons.copy),
              tooltip: "Benutzername speichern"),
          IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: pwObjekt.passwort));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwort gespeichert")));
              },
              icon: const Icon(Icons.copy),
              tooltip: "Passwort speichern"),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BearbeitenPW(
                              pw: pwObjekt,
                            )));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
    ),
  );
}
