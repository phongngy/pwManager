import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwsafe/klassen/passwort.dart';
import 'package:pwsafe/pages/hinzufuegen.dart';
import 'package:pwsafe/provider/pw_provider.dart';
import 'package:pwsafe/sharedWidget/listtile_passwort.dart';

class PWList extends StatefulWidget {
  const PWList({Key? key}) : super(key: key);

  @override
  State<PWList> createState() => _PWListState();
}

class _PWListState extends State<PWList> {
  @override
  void initState() {
    Provider.of<PWProvider>(context, listen: false).initPWList();
    super.initState();
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddPW()));
              },
              icon: const Icon(Icons.add))
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
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.delete, color: Colors.white),
                    ]),
              ),
            ),
            key: UniqueKey(),
            child: PWListTile(
                pwObjekt: pwlist[index],
                titel: pwlist[index].titel,
                farbe: pwlist[index].color,
                context: context),
          ),
        ),
      ),
    );
  }
}
