import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwsafe/fixValues/mycolor.dart';
import 'package:pwsafe/klassen/passwort.dart';
import 'package:pwsafe/pages/auth.dart';
import 'package:pwsafe/pages/einstellung.dart';
import 'package:pwsafe/pages/hinzufuegen.dart';
import 'package:pwsafe/provider/pw_provider.dart';
import 'package:pwsafe/sharedWidget/listtile_passwort.dart';

class PWList extends StatefulWidget {
  const PWList({Key? key}) : super(key: key);

  @override
  State<PWList> createState() => _PWListState();
}

class _PWListState extends State<PWList> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    Provider.of<PWProvider>(context, listen: false).initPWList();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void startTimer() {
    _timer = null;
    const delay = Duration(minutes: 10);
    _timer = Timer(
      delay,
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      startTimer();
    } else if (state == AppLifecycleState.resumed) {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pwprovider = Provider.of<PWProvider>(context, listen: true);
    List<Passwort> pwlist = pwprovider.pwList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Passwort Liste"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Einstellung()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: pwlist.length,
          itemBuilder: (context, index) => Dismissible(
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              pwprovider.delete(pwlist[index]);
            },
            background: Container(
              margin: const EdgeInsets.only(top: 16, bottom: 8),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [pwlist[index].color, AppColor.background],
                      begin: Alignment.centerLeft,
                      end: const Alignment(0.0, 0.5))),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Löschen")
                ]),
              ),
            ),
            key: UniqueKey(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: pwListTile(
                  pwObjekt: pwlist[index],
                  titel: pwlist[index].titel,
                  farbe: pwlist[index].color,
                  context: context),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddPW()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
