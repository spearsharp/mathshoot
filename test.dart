// import 'dart:ffi';
// import 'dart:io';
// import 'dart:js_util';
import 'dart:math';

// import 'package:flutter/material.dart';

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

void main() {
  // for (int i = 0; i < 5000000; i++) {
  //   print(i);
  // }
  var result = arith().getArith("1", 1, 3, "test");

  var result1 = arith().calcModule(1, 3, "+");
  print("result:$result");
  print("result1:$result1");
}

class arith {
  // calc the minimum equation
  int calcModule(int aa, int bb, String t) {
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
    return answer1;
  }

  Map<String, Object> arithgene(
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
      var result = calcModule(a, b, calcsymbol[Random(0).nextInt(3)]);
      print("result:$result");
    } else {}

    for (int i = 0; i < calcNumAmt; i++) {
      num calcsNum = Random(0).nextInt(10);
      print("get random number of calc");
      numArray.add(calcsNum);
      print("calcnum:$calcsNum");
    }
    print("numArray:$numArray"); // print number list

    // for (int i = 0; i < calcSymbolNum; i++) {
    //   if (calcSymbolNum == 1) {
    //     num radomNumOfCalcSymbol = Random(0).nextInt(3);
    //   } else {
    //     num radomNumOfCalcSymbol = Random(0).nextInt(4);
    //   }

    //   print("get random number of calc");
    //   for (int j = 0; j < radomNumOfCalcSymbol; j++) {
    //     symbolArray.add(calcsymbol[Random(0).nextInt(radomNumOfCalcSymbol)]);
    //     print("radomNumOfCalcSymbol:$radomNumOfCalcSymbol");
    //   }
    // }
    // ;
    // print("symbolArray:$symbolArray"); // print all symbol list

    // List arithQuoteSentence = []; // compose arith sentence
    // for (int k = 0; k < numArray.length + symbolArray.length; k++) {
    //   arithQuoteSentence.add(numArray[k]);
    //   if (symbolArray[k] == null) {
    //     continue;
    //   } else if (symbolArray[k] == '()') {
    //     bool parenthesesOne = false;
    //     bool parenthesesPair = false;
    //     if (k == 0 || k == 2 || k == 4) {
    //       arithQuoteSentence.add("(");
    //       parenthesesOne = true;
    //     }
    //   } else {
    //     arithQuoteSentence.add(symbolArray[k]);
    //   }
    // }

    // print(
    //     "arithQuoteSentence:$arithQuoteSentence"); // compose arithQuoteSentence

    // if (symbolArray.contains("()")) {
    // } else {}

    // if (calcNumAmt == 2) {
    // } else {
    //   if (symbolArray.contains("()")) {
    //   } else {}
    // }

    print("generate arithquote");
    print("key:$key");
    print("level:$level");

    // String arithsentence = str1 + str2;
    arithquote = {"level1": answer1};

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

//Test new function for learning
class _DartTypeState {
  void call() {
    dynamicDemo();

    varDemo();

    objectDemo();
  }

  dynamicDemo() {
    dynamic d = "CSDN";

    // 打印 dynamic 变量的运行时类型
    print(d.runtimeType);
    // 打印 dynamic 变量值
    print(d);

    // 调用 dynamic 变量的方法, 静态编译时无法检查其中的错误, 运行时会报错
    //d.getName();

    // 为 dynamic 变量赋值 int 数据
    d = 666;
    // 打印 dynamic 变量的运行时类型
    print(d.runtimeType);
    // 打印 dynamic 变量值
    print(d);
  }

  varDemo() {
    // 声明 var 变量
    var d = "CSDN";

    // 打印 var 变量的运行时类型
    print(d.runtimeType);
    // 打印 var 变量值
    print(d);

    // 将已经被自动推测为 String 类型的 d 变量赋值一个 int 类型值
    // 此时就会在编译时报错
    //d = 666;
  }

  objectDemo() {
    // 定义 Object 类型变量
    Object d = "CSDN";

    // 调用 Object 对象的方法
    // 打印 var 变量的运行时类型
    print(d.runtimeType);
    // 打印 var 变量值
    print(d);

    // 调用 Object 不存在的方法就会报错
    //d.getName()
  }
}
