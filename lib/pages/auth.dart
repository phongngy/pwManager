import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pwsafe/klassen/get_it.dart';
import 'package:pwsafe/klassen/local_auth.dart';
import 'package:pwsafe/pages/pwlist.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = getItInjector<Auth>();
  late String _msg = '';

  late bool _istAuthentifziert;
  bool _authentifzierungFehlgeschlagen = false;

  @override
  void initState() {
    super.initState();
    _authProzess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _authentifzierungFehlgeschlagen
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _msg,
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _authProzess();
                    },
                    child: const Text("Nochmal authentifzieren"),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: () async {
                  await _authProzess();
                },
                child: const Text("Authentifzieren"),
              ),
      ),
    );
  }

  Future<void> _authProzess() async {
    try {
      _istAuthentifziert = await auth.authentifizieren();
      setState(() {
        if (_istAuthentifziert) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const PWList()),
          );
        } else {
          _authentifzierungFehlgeschlagen = true;
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'auth_in_progress') {
        _msg = "Authentifizierung ist noch im Gange";
      }
    } catch (e) {
      _msg = "Unerwarteter Fehler";
    }
  }
}
