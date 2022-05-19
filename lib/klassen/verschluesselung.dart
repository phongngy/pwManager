import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

class Verschluesselung {
// For Fernet Encryption/Decryption
  static final keyFernet =
      encrypt.Key.fromUtf8('DasIstNichtDerPrivateKey!!!!!!!!');
  // encrypt.Key.fromUtf8('TechWithVPIsBestTechWithVPIsBest');
  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  static final fernet = encrypt.Fernet(keyFernet);
  static final encrypterFernet = encrypt.Encrypter(fernet);

  static encryptFernet(text) {
    final encrypted = encrypterFernet.encrypt(text);
    print(encrypted.base64);
    print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
    return encrypted.base64;
  }

  static decryptFernet(text) {
    return encrypterFernet.decrypt64(text);
  }
}
