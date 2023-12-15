import 'dart:ffi';
import 'dart:io';
import 'dart:js_util';
import 'dart:math';

import 'package:flutter/material.dart';

import '../model/arithModel.dart';

late int a,
    b,
    c,
    d,
    e,
    calcNumAmt,
    calcSymbolNum,
    answer,
    answer1,
    answer2,
    radomNumOfCalcSymbol,
    calcparentheis;
late String str1, str2, str3, str4, str5, str6, str7, str8, str9, str10;
String questionMark = '?';
late Map<String, Object> arithquote;
const List calcsymbol = ['+', '-', '×', '÷', '()'];

class arith {
  static int calcModule(int aa, int bb, String t) {
    switch (t) {
      case "+":
        answer1 = aa + bb;
      case "-":
        answer1 = aa - bb;
      case "×":
        answer1 = aa * bb;
      case "÷":
        answer1 = (aa / bb) as int;
      default:
        answer1 = 0;
    }
    return answer;
  }

  static Map<String, Object> arithgene(
    key,
    level,
  ) {
    switch (level ~/ 3) {
      case 0:
        calcNumAmt = 2;
        calcSymbolNum = calcNumAmt - 1; // must haven't ()  , symbol without ()
        calcparentheis = 0;
      case 1:
        calcNumAmt = 3; //2-3 pick numbers of number
        calcSymbolNum = calcNumAmt -
            1; // can have ()  symbol without () ,must with nums of num minius 1.
        calcparentheis = calcNumAmt ~/ 2; // 1-calcNumAmt~/2 random number of ()
      case 2:
        calcNumAmt = 3;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/ 2; // 0-calcNumAmt~/2 random number of ()
      case 3:
        calcNumAmt = 4;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/ 2; // 0-calcNumAmt~/2 random number of ()
      case 3:
      case 4:
        calcNumAmt = 4;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/
            2; // 1-calcNumAmt~/2 random number of (),when there are two () , need two more symbol included
      case 3:
      default:
        calcNumAmt = 2;
        calcSymbolNum = 1; //
        calcparentheis = 0;
    }
    ;
    List calcSymbolPriority = [
      ['()'],
      ['×', '÷'],
      ['+', '-'],
    ];

    List numArray = [];
    List symbolArray = [];

    if (calcNumAmt == 2) {
      a = Random(0).nextInt(10);
      b = Random(0).nextInt(10);
      Object? calcsym = calcsymbol[0]['+'];
    } else {}

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
        bool parenthesesOne = false;
        bool parenthesesPair = false;
        if (k == 0 || k == 2 || k == 4) {
          arithQuoteSentence.add("(");
          parenthesesOne = true;
        }
      } else {
        arithQuoteSentence.add(symbolArray[k]);
      }
    }

    print(
        "arithQuoteSentence:$arithQuoteSentence"); // compose arithQuoteSentence

    if (symbolArray.contains("()")) {
    } else {}

    if (calcNumAmt == 2) {
    } else {
      if (symbolArray.contains("()")) {
      } else {}
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
