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
    final length = random.nextInt(1).toInt() + minLength;

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
}
