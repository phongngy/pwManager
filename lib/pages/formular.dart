import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwsafe/fixValues/mycolor.dart';
import 'package:pwsafe/klassen/passwort.dart';
import 'package:pwsafe/provider/pw_provider.dart';

class Formular extends StatefulWidget {
  const Formular({Key? key}) : super(key: key);

  @override
  State<Formular> createState() => _FormularState();
}

class _FormularState extends State<Formular> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titelController = TextEditingController();
  final benutzerController = TextEditingController();
  final pw1Controller = TextEditingController();
  final pw2Controller = TextEditingController();
  late Color _color = AppColor.lila;

  bool _pwvisible = true;
  @override
  void dispose() {
    titelController.dispose();
    benutzerController.dispose();
    pw1Controller.dispose();
    pw2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: titelController,
                decoration: const InputDecoration(
                  hintText: 'Titel eingeben',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte fülle das Feld';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: benutzerController,
                decoration: const InputDecoration(
                  hintText: 'Benutzername eingeben',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte fülle das Feld';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: pw1Controller,
                obscureText: _pwvisible,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte fülle das Feld';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Passwort eingeben',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _pwvisible = !_pwvisible;
                        });
                      },
                      icon: _pwvisible
                          ? const Icon(
                              Icons.visibility,
                            )
                          : const Icon(Icons.visibility_off)),
                ),
              ),
              TextFormField(
                controller: pw2Controller,
                obscureText: _pwvisible,
                decoration: const InputDecoration(
                  hintText: 'Passwort bestaetigen',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Wähle Farbe:"),
                  DropdownButton<Color>(
                      value: _color,
                      icon: const Icon(Icons.arrow_downward),
                      items: <Color>[
                        AppColor.lila,
                        AppColor.hellbraun,
                        AppColor.orange,
                        AppColor.pink
                      ].map<DropdownMenuItem<Color>>((Color item) {
                        return DropdownMenuItem<Color>(
                            value: item,
                            child: Container(width: 50, color: item));
                      }).toList(),
                      onChanged: (Color? value) {
                        setState(() {
                          _color = (value!);
                        });
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () {
                    if (pw1Controller.text == pw2Controller.text &&
                        _formKey.currentState!.validate()) {
                      Provider.of<PWProvider>(context, listen: false).add(
                        Passwort(
                            titel: titelController.text,
                            benutzername: benutzerController.text,
                            passwort: pw1Controller.text,
                            color: _color),
                      );
                      Navigator.pop(context);
                    } else {
                      throw Exception("Passwörter nicht gleich");
                    }
                  },
                  child: const Text("Erstellen"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
