import 'dart:math';

class PasswordGenerator {
  bool useLowerCase;
  bool useUpperCase;
  bool useDigits;
  bool useSpecialCharacters;
  int minLength;

  PasswordGenerator({
    this.useLowerCase = true,
    this.useUpperCase = true,
    this.useDigits = true,
    this.useSpecialCharacters = true,
    this.minLength = 8,
  });

  String generate() {
    String chars = '';
    if (useLowerCase) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (useUpperCase) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (useDigits) chars += '0123456789';
    if (useSpecialCharacters) chars += '!@#%^&*()_+{}|:<>?-=[];,./';

    final random = Random.secure();
    final length = random.nextInt(10).toInt() + minLength;

    List<String> wort = [];
    int wortAnfang = 0;

    if (minLength > 2) {
      if (useLowerCase && useUpperCase) {
        String buchstabenListe =
            'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

        wort = List.generate(3,
            (index) => buchstabenListe[random.nextInt(buchstabenListe.length)]);
      } else if (useLowerCase) {
        String buchstabenListe = 'abcdefghijklmnopqrstuvwxyz';

        wort = List.generate(3,
            (index) => buchstabenListe[random.nextInt(buchstabenListe.length)]);
      } else if (useUpperCase) {
        String buchstabenListe = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        wort = List.generate(3,
            (index) => buchstabenListe[random.nextInt(buchstabenListe.length)]);
      }

      wortAnfang = random.nextInt(length - 3);
    }

    List<String> pw =
        List.generate(length, (index) => chars[random.nextInt(chars.length)]);

    if (wort.isNotEmpty) {
      for (var i = 0; i < 3; i++) {
        pw[wortAnfang] = wort[i];
        wortAnfang += 1;
      }
    }

    return pw.join();
  }

  double evaluatePasswordStrength(String password) {
    double strength = 0;

    if (RegExp(r'[A-Z]').hasMatch(password)) {
      strength += 0.2;
    }

    if (RegExp(r'[a-z]').hasMatch(password)) {
      strength += 0.2;
    }

    if (RegExp(r'[0-9]').hasMatch(password)) {
      strength += 0.2;
    }

    if (RegExp(r'[!@#%^&*()_+{}|:<>?=\[\];,./]').hasMatch(password)) {
      strength += 0.2;
    }

    if (RegExp(r'[a-zA-Z]{3}').hasMatch(password)) {
      strength += 0.2;
    }

    if (password.length >= 8) {
      if (strength + 0.2 > 1) {
        strength = 1;
      } else {
        strength += 0.2;
      }
    } else if (strength > 0.6) {
      strength = 0.6;
    }

    return strength;
  }
}
