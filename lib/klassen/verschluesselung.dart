import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Verschluesselung {
// For Fernet Encryption/Decryption
  static final keyFernet = encrypt.Key.fromUtf8(dotenv.get('key'));
  // encrypt.Key.fromUtf8('TechWithVPIsBestTechWithVPIsBest');
  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  static final fernet = encrypt.Fernet(keyFernet);
  static final encrypterFernet = encrypt.Encrypter(fernet);

  static encryptFernet(text) {
    final encrypted = encrypterFernet.encrypt(text);
    //print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
    return encrypted.base64;
  }

  static decryptFernet(text) {
    return encrypterFernet.decrypt64(text);
  }
}
