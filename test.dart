// import 'dart:ffi';
// import 'dart:io';
// import 'dart:js_util';
import 'dart:convert';
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
    rangNum,
    answer1,
    answer2,
    radomNumOfCalcSymbol,
    calcparentheis;
late String arithstring,
    str1,
    str2,
    str3,
    str4,
    str5,
    str6,
    str7,
    str8,
    str9,
    str10;
String questionMark = '?';
late num answertmp;
bool calcend = false;
late Map<String, String> arithquote;
const List uniqNum = [1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
const List calcsymbol = ['+', '-', '×', '÷', '()'];

Future<void> main() async {
  // for (int i = 0; i < 5000; i++) {
  //   // print(i);
  //   print(Random().nextInt(10));
  // }
  for (int q = 0; q < 100; q++) {
    var result = await arith().getArith("1", 1, 3, "test");
    var jsonresult = jsonEncode(result);
    print("result:$q+$jsonresult");
  }

  //  for (int q = 0; q < 100; q++) {
  //   num aa = Random().nextInt(100);
  //   num bb = Random().nextInt(100);
  //   late num cc;

  //   cc = aa % bb;
  //   print("$aa'/'$bb'=' $cc");
  // }
  // print("result1:$result1");
}

class arith {
  // calc the minimum equation
  Map<String, int> calcModule(num aa, num bb, String t, bool calcend) {
    switch (t) {
      case "+":
        answertmp = aa + bb;
      case "-":
        answertmp = aa - bb;
      case "×":
        answertmp = aa * bb;
      case "÷":
        if (bb == 0) {
          bb = 1;
        }
        if (aa % bb != 0) {
          int tmpcountdivide = aa.toInt(); //temp using
          int tmpcount = 0;
          List tmpcmmdivide = []; //temp using
          for (int r = tmpcountdivide; r > 0; r--) {
            if (aa % tmpcountdivide == 0) {
              tmpcmmdivide.add(r);
              tmpcount++;
              print("tmpcount:$tmpcount");
              print("tmpcountdivide:$tmpcountdivide");
            }
          }
          tmpcountdivide >= 2
              ? bb = tmpcmmdivide[Random().nextInt(tmpcount)]
              : bb = tmpcmmdivide[0];
          print("tmpcmmdivide:$tmpcmmdivide");
          print("tmpcount:$tmpcount");
          print("tempmutiple:$bb");
          answertmp = (aa / bb);
        } else {
          try {
            answertmp = (aa / bb);
          } on Exception catch (e) {
            print("Error:$e");
          }
        }
    }
    a = aa.toInt();
    b = bb.toInt();
    c = answertmp.toInt();
    Map<String, int> tempcalcret = {"a": a, "b": b, "calresult": c};
    return tempcalcret;
  }

  Map<String, String> arithgene(
    key,
    level,
  ) {
    print("generate arithquote");
    print("key:$key");
    print("level:$level");
    switch (level ~/ 3) {
      case 0:
        calcNumAmt = 2;
        calcSymbolNum = calcNumAmt - 1; // must haven't ()  , symbol without ()
        calcparentheis = 0;
        rangNum = 10;
      case 1:
        calcNumAmt = 3; //2-3 pick numbers of number
        calcSymbolNum = calcNumAmt -
            1; // can have ()  symbol without () ,must with nums of num minius 1.
        calcparentheis = calcNumAmt ~/ 2; // 1-calcNumAmt~/2 random number of ()
        rangNum = 25;
      case 2:
        calcNumAmt = 3;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/ 2; // 0-calcNumAmt~/2 random number of ()
        rangNum = 50;
      case 3:
        calcNumAmt = 4;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/ 2; // 0-calcNumAmt~/2 random number of ()
        rangNum = 75;
      case 3:
      case 4:
        calcNumAmt = 4;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/
            2; // 1-calcNumAmt~/2 random number of (),when there are two () , need two more symbol included
        rangNum = 100;
      case 3:
      default:
        calcNumAmt = 2;
        calcSymbolNum = 1; //
        calcparentheis = 0;
    }

    List calcSymbolPriority = [
      ['()'],
      ['×', '÷'],
      ['+', '-'],
    ];

    List numArray = [];
    List calcsymbolArray = [];

    //get number involved into calc
    print("calcNumAmt$calcNumAmt");
    print("rangNum:$rangNum");
    for (int i = 0; i < calcNumAmt; i++) {
      numArray.add(Random().nextInt(rangNum));
      print("totalNum:$numArray");
    }

    //get calc simbol involved into calc
    print("calcSymbolNum$calcSymbolNum");
    for (int i = 0; i < calcSymbolNum; i++) {
      calcsymbolArray.add(calcsymbol[Random().nextInt(4)]);
      print("allCalcSimbol:$calcsymbolArray");
    }

    //get () simbol involved into calc
    print("Num of calcparentheis:$calcparentheis");
    if (calcNumAmt <= 2) {
      print("calcNun less than 2");
      a = Random().nextInt(rangNum);
      b = Random().nextInt(rangNum);
      str1 = calcsymbolArray[calcSymbolNum - 1];
      Map<String, int> calresult = calcModule(a, b, str1, calcend);
      if (calresult["calresult"]! >= 0) {
        arithstring = a.toString() + str1 + b.toString() + "=" + "?";
      } else {
        print("result is negative");
        arithstring = b.toString() + str1 + a.toString() + "=" + "?";
        calresult["calresult"] = -calresult["calresult"]!;
      }
      ;
      print("result:$calresult");
      print("arithstring:$arithstring");
      arithquote = {"result": calresult.toString(), "level1": arithstring};
    } else {}

    //compose and calc the answer   1. when abstract to negative , then switch the position , when divided into decimal, use 1,2,3,5,7 to binarray tree tract get an abandom figure

// Previous section
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

    return arithquote;
  }

  Future<Map<String, String>> getArith(
      String key, int? level, int calcnum, String? arithquote) async {
    print("arithquote:$arithquote");
    // int calcsRandomCat =
    //     Random(2).nextInt(calcnum); //generate calc compliation , 1-calcnum

    late String get_Random_symbol; // = calcsymbol[Random(0).nextInt(4)];

    final Map<String, String> arithmodule =
        arithgene(key, level); // call a subroutine
    return arithmodule;
  }
}

//Test new function for learning
// class _DartTypeState {
//   void call() {
//     dynamicDemo();

//     varDemo();

//     objectDemo();
//   }

//   dynamicDemo() {
//     dynamic d = "CSDN";

//     // 打印 dynamic 变量的运行时类型
//     print(d.runtimeType);
//     // 打印 dynamic 变量值
//     print(d);

//     // 调用 dynamic 变量的方法, 静态编译时无法检查其中的错误, 运行时会报错
//     //d.getName();

//     // 为 dynamic 变量赋值 int 数据
//     d = 666;
//     // 打印 dynamic 变量的运行时类型
//     print(d.runtimeType);
//     // 打印 dynamic 变量值
//     print(d);
//   }

//   varDemo() {
//     // 声明 var 变量
//     var d = "CSDN";

//     // 打印 var 变量的运行时类型
//     print(d.runtimeType);
//     // 打印 var 变量值
//     print(d);

//     // 将已经被自动推测为 String 类型的 d 变量赋值一个 int 类型值
//     // 此时就会在编译时报错
//     //d = 666;
//   }

//   objectDemo() {
//     // 定义 Object 类型变量
//     Object d = "CSDN";

//     // 调用 Object 对象的方法
//     // 打印 var 变量的运行时类型
//     print(d.runtimeType);
//     // 打印 var 变量值
//     print(d);

//     // 调用 Object 不存在的方法就会报错
//     //d.getName()
//   }
// }
