import 'dart:math';

import 'package:uuid/uuid.dart';

class Tools {
  static uuid() {
    var uuid = Uuid();
    var uuidv1 = uuid.v1();
    return uuid;
  }

  static uName<String>(int v) {
    var randomString;
    Random random = Random();
    if (v > 10) {
      randomString = "LengthErr";
    } else {
      const characters =
          '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      for (int i = 0; i < v; i++) {
        int index = random.nextInt(v);
        String char = characters[index] as String;
        randomString += char;
      }
    }
    return randomString;
  }
}
