import 'dart:ffi';
import 'dart:math';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class Tools {
  static uuid() {
    var uuid = const Uuid();
    return uuid;
  }

  static uName<String>(int v) {
    String randomStringHead = "MS-" as String;
    String uName = '' as String;

    if (v > 10) {
      uName = "LengthErr" as String;
    } else {
      List characters = [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
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
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z'
      ];
      for (int i = 0; i < v!; i++) {
        String tmpchar = characters[Random().nextInt(characters.length)];
        randomStringHead =
            (randomStringHead!.toString() + tmpchar!.toString()) as String;
      }
    }
    uName = randomStringHead;
    return uName;
  }
}
