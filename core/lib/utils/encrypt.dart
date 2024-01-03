import 'package:encrypt/encrypt.dart';

String encrypt(String plainText) {
  final key = Key.fromUtf8('eVwB9GKsJhA8v52c738RsPRuMs6SyJhw');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}
