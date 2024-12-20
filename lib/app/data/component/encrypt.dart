import 'dart:convert';

import 'package:flutter/services.dart';

class Encrypt {
  static String enkrip(String txt) {
    String hasil = "";
    txt = txt.split('').reversed.join();
    int panjangStr = txt.length;
    for (int h = 0; h < panjangStr; h++) {
      hasil += String.fromCharCode(txt.codeUnitAt(h) + 3);
    }
    return hasil;
  }

  static String dekrip(String txt) {
    String hasil = "";
    int panjangStr = txt.length;
    for (int h = 0; h < panjangStr; h++) {
      hasil += String.fromCharCode(txt.codeUnitAt(h) - 3);
    }
    hasil = hasil.split('').reversed.join();
    return hasil;
  }

  static Map<String, dynamic> dekripData(String data) {
    String dec = dekrip(data);
    Uint8List base = base64.decode(dec);
    String utf = utf8.decode(base);
    dynamic dynamicJson = json.decode(utf);
    final jsonx = dynamicJson as Map<String, dynamic>;
    return jsonx;
  }

  static String enkripData(Map<String, dynamic> data) {
    String json = jsonEncode(data);
    List<int> utf = utf8.encode(json);
    String base = base64.encode(utf);
    return enkrip(base);
  }
}
