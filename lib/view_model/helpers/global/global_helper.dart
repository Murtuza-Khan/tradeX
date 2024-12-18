import 'dart:math';
import 'package:flutter/cupertino.dart';

import '../../../resources/exports/index.dart';

class GlobalHelper {
  static Set<int> setOfInts = {};

  static Widget loadingWidget({Color? color}) {
    return Platform.isAndroid
        ? Center(
            child: CircularProgressIndicator(
              color: color ?? AppColors.white,
              strokeWidth: 2,
            ),
          )
        : Center(
            child: CupertinoActivityIndicator(
              color: color ?? AppColors.white,
              radius: 12,
            ),
          );
  }

  static String formatedNumber({int? value}) {
    int? points = value ?? 0;
    return points < 999999999
        ? points.getFormattedCurrency(showSymbol: false)
        : points.getCompactCurrency();
  }

  static int getRandomId() {
    int value = Random().nextInt(99999999);
    while (setOfInts.contains(value)) {
      value = Random().nextInt(99999999);
    }
    setOfInts.add(value);
    return setOfInts.last;
  }

  static double getDiscountPice(double price, int disPer) {
    double disPrice = (disPer / 100) * price;
    if (disPrice.isInfinite || disPrice.isNegative) return 0.0;
    return disPrice;
  }

  static String encrypt(dynamic value) {
    String key = dotenv.get('API_ENCRYPTION_KEY');
    String data = jsonEncode(value);
    List<int> charCodes = [];
    for (int i = 0; i < data.length; i++) {
      int charCode = data.codeUnitAt(i);
      charCode = (charCode + key.codeUnitAt(i % key.length)) % 256;
      charCodes.add(charCode);
    }
    return base64Encode(Uint8List.fromList(charCodes));
  }

  static dynamic decrypt(String encryptedData) {
    String key = dotenv.get('API_ENCRYPTION_KEY');

    Uint8List decodedData = base64Decode(encryptedData);
    List<int> charCodes = decodedData.toList();

    String decrypted = "";
    for (int i = 0; i < charCodes.length; i++) {
      int charCode = charCodes[i];
      int keyIndex = i % key.length;
      charCode = (charCode - key.codeUnitAt(keyIndex) + 256) % 256;
      decrypted += String.fromCharCode(charCode);
    }
    return jsonDecode(decrypted);
  }

  static List<String> alphabets = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];
}
