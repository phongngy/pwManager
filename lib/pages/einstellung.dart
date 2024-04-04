import 'package:flutter/material.dart';
import 'package:pwsafe/klassen/get_it.dart';
import 'package:pwsafe/klassen/passwort_generator.dart';

class Einstellung extends StatefulWidget {
  const Einstellung({super.key});

  @override
  State<Einstellung> createState() => _EinstellungState();
}

class _EinstellungState extends State<Einstellung> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pwMinLaengeController = TextEditingController();
  final pwGenerator = getItInjector<PasswordGenerator>();

  bool _ziffern = false;
  bool _kleinBuchstaben = false;
  bool _grossBuchstaben = false;
  bool _sonderzeichen = false;

  @override
  void initState() {
    _ziffern = pwGenerator.useDigits;
    _kleinBuchstaben = pwGenerator.useLowerCase;
    _grossBuchstaben = pwGenerator.useUpperCase;
    _sonderzeichen = pwGenerator.useSpecialCharacters;
    pwMinLaengeController.text = pwGenerator.minLength.toString();
    super.initState();
  }

  void dispose() {
    pwMinLaengeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passwortgenerator Einstellungen"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                    child: TextFormField(
                      controller: pwMinLaengeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Mindestlänge eintragen',
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: CheckboxListTile(
                        title: const Text("Ziffern erlauben"),
                        value: _ziffern,
                        onChanged: (bool? value) {
                          setState(() {
                            _ziffern = !_ziffern;
                          });
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: CheckboxListTile(
                        title: const Text("Kleinbuchstaben erlauben"),
                        value: _kleinBuchstaben,
                        onChanged: (bool? value) {
                          setState(() {
                            _kleinBuchstaben = !_kleinBuchstaben;
                          });
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: CheckboxListTile(
                        title: const Text("Großbuchstaben erlauben"),
                        value: _grossBuchstaben,
                        onChanged: (bool? value) {
                          setState(() {
                            _grossBuchstaben = !_grossBuchstaben;
                          });
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: CheckboxListTile(
                        title: const Text("Sonderzeichen erlauben"),
                        value: _sonderzeichen,
                        onChanged: (bool? value) {
                          setState(() {
                            _sonderzeichen = !_sonderzeichen;
                          });
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (pwMinLaengeController.text.isNotEmpty) {
                            pwGenerator.minLength =
                                int.parse(pwMinLaengeController.text);
                          } else {
                            pwGenerator.minLength = 8;
                          }
                          pwGenerator.useDigits = _ziffern;
                          pwGenerator.useLowerCase = _kleinBuchstaben;
                          pwGenerator.useUpperCase = _grossBuchstaben;
                          pwGenerator.useSpecialCharacters = _sonderzeichen;
                          Navigator.pop(context);
                        } else {
                          throw Exception(
                              "Passworteinstellungen konnten nicht veraendert werden");
                        }
                      },
                      child: const Text("Speichern"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
