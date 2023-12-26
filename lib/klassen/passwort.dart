import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:pwsafe/fixValues/mycolor.dart';
import 'package:pwsafe/klassen/verschluesselung.dart';
import 'package:pwsafe/klassen/verschluesselung_aes.dart';

class Passwort {
  late String? benutzername;
  late String passwort;
  late String titel;
  late Color color;
  late String? iv;

  String? id;

  Passwort(
      {this.benutzername,
      required this.passwort,
      required this.titel,
      required this.color,
      this.iv,
      this.id});

  Map<String, dynamic> toJson() => {
        'id': id ?? "",
        'benutzername': benutzername ?? "",
        //'passwort': Verschluesselung.encryptFernet(passwort),
        'passwort': VerschluesselungAESCTR.encrpytAESCTR(passwort).base64,
        'iv': VerschluesselungAESCTR.iv.base64,
        'titel': titel,
        'color': color.toString()
      };

  factory Passwort.fromJson(MapEntry<String, dynamic> map) {
    return Passwort(
        id: map.key.substring(
            map.key.substring(map.key.indexOf('/') + 1).indexOf('/') + 2),
        benutzername: map.value['benutzername'],
        //passwort: Verschluesselung.decryptFernet(map.value['passwort']),
        passwort: VerschluesselungAESCTR.decryptAESCTR(
            Encrypted(base64.decode(map.value['passwort'])),
            IV(base64.decode(map.value['iv']))),
        color: AppColor.colorFinden(map.value['color']),
        titel: map.value['titel'],
        iv: map.value['iv']);
  }
}
