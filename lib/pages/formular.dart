import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwsafe/fixValues/mycolor.dart';
import 'package:pwsafe/klassen/get_it.dart';
import 'package:pwsafe/klassen/passwort.dart';
import 'package:pwsafe/klassen/passwort_generator.dart';
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
  final pwController = TextEditingController();
  final pwGenerator = getItInjector<PasswordGenerator>();
  late Color _color = AppColor.lila;

  double passwordStrength = 0;
  bool _pwvisible = true;

  @override
  void initState() {
    super.initState();
    pwController.addListener(() {
      setState(() {
        passwordStrength =
            pwGenerator.evaluatePasswordStrength(pwController.text);
      });
    });
  }

  @override
  void dispose() {
    titelController.dispose();
    benutzerController.dispose();
    pwController.dispose();
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
                textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Benutzername eingeben',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: pwController,
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
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: passwordStrength,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        getStrengthColor(passwordStrength)),
                    backgroundColor: AppColor.background,
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      pwController.text = pwGenerator.generate();
                    },
                    child: const Text('Passwort generieren'),
                  )),
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
                        icon: const Icon(Icons.arrow_downward,
                            color: AppColor.secondary),
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
                      Provider.of<PWProvider>(context, listen: false).add(
                        Passwort(
                          titel: titelController.text,
                          benutzername: benutzerController.text,
                          passwort: pwController.text,
                          color: _color,
                        ),
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

Color getStrengthColor(double strength) {
  if (strength > 0.8) {
    return Colors.green;
  } else if (strength >= 0.4) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}
