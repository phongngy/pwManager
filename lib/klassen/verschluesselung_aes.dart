import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VerschluesselungAESCTR {
  static final key = Key.fromUtf8(dotenv.get('key'));
  static final iv = IV.fromLength(16);

  static final encrypter =
      Encrypter(AES(key, mode: AESMode.ctr, padding: null));

  static Encrypted encrpytAESCTR(String pw) {
    return encrypter.encrypt(pw, iv: iv);
  }

  static String decryptAESCTR(Encrypted pw, IV iv) {
    return encrypter.decrypt(pw, iv: iv);
  }
}
