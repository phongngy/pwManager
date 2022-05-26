import 'package:flutter/material.dart';
import 'package:pwsafe/fixValues/mycolor.dart';
import 'package:pwsafe/klassen/verschluesselung.dart';

class Passwort {
  late String benutzername;
  late String passwort;
  late String titel;
  late Color color;

  String? id;

  Passwort(
      {required this.benutzername,
      required this.passwort,
      required this.titel,
      required this.color,
      this.id});

  Map<String, dynamic> toJson() => {
        'id': id ?? "",
        'benutzername': benutzername,
        'passwort': Verschluesselung.encryptFernet(passwort),
        'titel': titel,
        'color': color.toString()
      };

  factory Passwort.fromJson(MapEntry<String, dynamic> map) {
    return Passwort(
        id: map.key.substring(
            map.key.substring(map.key.indexOf('/') + 1).indexOf('/') + 2),
        benutzername: map.value['benutzername'],
        passwort: Verschluesselung.decryptFernet(map.value['passwort']),
        color: AppColor.colorFinden(map.value['color']),
        titel: map.value['titel']);
  }
}
