import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class Auth {
  final LocalAuthentication auth = LocalAuthentication();

/*
  Future<bool> checkBioMoeglich() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      return canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    } on Exception catch (e) {
      return false;
    }
  }
*/

  Future<bool> authentifizieren() async {
    try {
      return await auth.authenticate(
          localizedReason: 'Zugang zu den Passwörter',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Bio-Authentifizierung erforderlich',
              cancelButton: 'Abbrechen',
            ),
          ]);
    } on PlatformException {
      return false;
    }
  }
}
