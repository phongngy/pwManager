import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwsafe/fixValues/mycolor.dart';
import 'package:pwsafe/klassen/passwort.dart';
import 'package:pwsafe/provider/pw_provider.dart';

class FormularBearbeiten extends StatefulWidget {
  Passwort pw;
  FormularBearbeiten({Key? key, required this.pw}) : super(key: key);

  @override
  State<FormularBearbeiten> createState() => _FormularBearbeitenState();
}

class _FormularBearbeitenState extends State<FormularBearbeiten> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titelController = TextEditingController();
  final benutzerController = TextEditingController();
  final pw1Controller = TextEditingController();
  late Color _color;

  bool _pwvisible = true;

  @override
  void initState() {
    titelController.text = widget.pw.titel;
    benutzerController.text = widget.pw.benutzername;
    pw1Controller.text = widget.pw.passwort;
    _color = widget.pw.color;
    super.initState();
  }

  @override
  void dispose() {
    titelController.dispose();
    benutzerController.dispose();
    pw1Controller.dispose();
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
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte fülle das Feld';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: TextFormField(
                  controller: benutzerController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Benutzername eingeben',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte fülle das Feld';
                    }
                    return null;
                  },
                ),
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
                  prefixIcon: const Icon(Icons.lock),
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Wähle Farbe:",
                    ),
                    DropdownButton<Color>(
                        value: _color,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: AppColor.secondary,
                        ),
                        elevation: 0,
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
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<PWProvider>(context, listen: false).update(
                        Passwort(
                            id: widget.pw.id,
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
