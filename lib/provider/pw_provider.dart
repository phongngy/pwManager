import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:localstore/localstore.dart';
import 'package:pwsafe/klassen/passwort.dart';

class PWProvider with ChangeNotifier {
  var _pwList = <Passwort>[];
  final _db = Localstore.instance;

  UnmodifiableListView<Passwort> get pwList => UnmodifiableListView(_pwList);

  Future<void> initPWList() async {
    final documents = await _db.collection('passwort').get();

    if (documents != null) {
      var lokalpw =
          documents.entries.map((entry) => Passwort.fromJson(entry)).toList();
      _pwList.clear();
      for (final pw in lokalpw) {
        _pwList.add(pw);
      }
      _pwList.sort((a, b) => a.color.toString().compareTo(b.color.toString()));
      notifyListeners();
    }
  }

  void add(Passwort pw) {
    _db.collection("passwort").doc().set(pw.toJson());
    initPWList();
  }

  void delete(Passwort pw) {
    _db.collection('passwort').doc(pw.id).delete();
    initPWList();
  }

  void update(Passwort pw) {
    _db.collection("passwort").doc(pw.id).set(pw.toJson());
    initPWList();
  }
}
