import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../model/arithModel.dart';

late int a, b, c, d, e, calcNumAmt, calcSymbolNum, answer, radomNumOfCalcSymbol;
late String str1, str2, str3, str4, str5, str6, str7, str8, str9, str10;
String questionMark = '?';
late Map<String, Object> arithquote;
List<String> calcsymbol = ['+', '-', '×', '÷', '()'];

class arith {
  static Map<String, Object> arithgene(
    key,
    level,
  ) {
    switch (level ~/ 3) {
      case 0:
        calcNumAmt = 2;
        calcSymbolNum = 1; // must haven't ()
      case 1:
        calcNumAmt = 3;
        calcSymbolNum = 2; // can have ()
      case 2:
        calcNumAmt = 3;
        calcSymbolNum = 3; //can have ()
      case 3:
        calcNumAmt = 3;
        calcSymbolNum = 4; // must have ()
      case 4:
        calcNumAmt = 4;
        calcSymbolNum = 4; // can have ()
      default:
        calcNumAmt = 2;
        calcSymbolNum = 1; //
    }
    ;
    List calcSymbolPriority = [
      ['()'],
      ['×', '÷'],
      ['+', '-'],
    ];

    List numArray = [];
    List symbolArray = [];
    for (int i = 0; i < calcNumAmt; i++) {
      num calcsNum = Random(0).nextInt(10);
      print("get random number of calc");
      numArray.add(calcsNum);
      print("calcnum:$calcsNum");
    }
    print("numArray:$numArray"); // print number list

    for (int i = 0; i < calcSymbolNum; i++) {
      if (calcSymbolNum == 1) {
        num radomNumOfCalcSymbol = Random(0).nextInt(3);
      } else {
        num radomNumOfCalcSymbol = Random(0).nextInt(4);
      }

      print("get random number of calc");
      for (int j = 0; j < radomNumOfCalcSymbol; j++) {
        symbolArray.add(calcsymbol[Random(0).nextInt(radomNumOfCalcSymbol)]);
        print("radomNumOfCalcSymbol:$radomNumOfCalcSymbol");
      }
    }
    ;
    print("symbolArray:$symbolArray"); // print all symbol list

    List arithQuoteSentence = []; // compose arith sentence
    for (int k = 0; k < numArray.length + symbolArray.length; k++) {
      arithQuoteSentence.add(numArray[k]);
      if (symbolArray[k] == null) {
        continue;
      } else if (symbolArray[k] == '()') {
        arithQuoteSentence
            .add(calcsymbol[Random(0).nextInt(radomNumOfCalcSymbol)]);
      } else {
        arithQuoteSentence.add(symbolArray[k]);
      }
    }

    print("generate arithquote");
    print("key:$key");
    print("level:$level");

    String arithsentence = str1 + str2;

    return arithquote;
  }

  Future<Map<String, Object>> getArith(
      String key, int? level, int calcnum, String? arithquote) async {
    print("arithquote:$arithquote");

    int calcsRandomCat =
        Random(2).nextInt(calcnum); //generate calc compliation , 1-calcnum

    late String get_Random_symbol; // = calcsymbol[Random(0).nextInt(4)];

    final Map<String, Object> arithmodule =
        arithgene(key, level); // call a subroutine
    return arithmodule;
  }
}

// Object<arithModel> arithCalc() {
//   static arithCalcSentence(level) {
//     print("calc started");
//     return arithtence;
//   }
// }
