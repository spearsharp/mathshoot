// import 'dart:ffi';
// import 'dart:io';
// import 'dart:js_util';
import 'dart:convert';
import 'dart:math';

// import 'package:get/get.dart';

// import 'package:flutter/material.dart';

late int a,
    b,
    c,
    calcNumAmt,
    calcSymbolNum,
    answer,
    rangNum,
    answer1,
    answer2,
    radomNumOfCalcSymbol,
    calcparentheis;
late String arithstring, str1, str2, str3;
String questionMark = '?';
late num answertmp;
bool calcend = false;
late Map<String, String> arithquote;
const List uniqNum = [1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
const List calcsymbol = ['+', '-', '×', '÷', '()'];

Future<void> main() async {
  // for (int i = 0; i < 100; i++) {
  //   // print(i);
  //   print(Random().nextInt(10));
  //   print((randomGen(1, 9)));
  // }

  for (int q = 0; q < 10; q++) {
    var result = await arith().getArith("1", 5, 9, "test");
    var jsonresult = jsonEncode(result);
    print("result:$q+$jsonresult");
  }

  // for (int q = 0; q < 100; q++) {
  //   num aa = Random().nextInt(20);
  //   num bb = 9;
  //   late num cc;

  //   cc = aa ~/ bb;
  //   print("$aa'/'$bb'=' $cc");
  // }
  // print("result1:$result1");
}

//until
randomGen(min, max) {
  //nextInt 方法生成一个从 0（包括）到 max（不包括）的非负随机整数
  var x = Random().nextInt(max) + min;
  //如果您不想返回整数，只需删除 floor() 方法
  return x.floor();
}

getEvebGen(min, max) {
  var x = Random().nextInt(max) + min;
  var y = x ~/ 2;
  var z = y * 2;
  return z;
}

getOddGen(min, max) {
  var x = Random().nextInt(max) + min;
  var y = x ~/ 2;
  var z = y * 2 + 1;
  return z;
}

class arith {
  // calc the minimum equation
  Map<String, int> calcModule(num aa, num bb, String t, bool calcend) {
    switch (t) {
      case "+":
        answertmp = aa + bb;
      case "-":
        answertmp = aa - bb;
        if (answertmp < 0) {
          print("abstract answer is nagetive");
          num aatmp = aa;
          aa = bb;
          bb = aatmp;
          answertmp = -answertmp;
        }
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
      case "(":
      case ")":
    }
    a = aa.toInt();
    b = bb.toInt();
    c = answertmp.toInt();
    Map<String, int> tempcalcret = {"a": a, "b": b, "calresult": c};
    return tempcalcret;
  }

//segement composing and computing
  Map<dynamic, dynamic> calcComposeModule(String a, String b, String c) {
    Map<String, String> composedEquotion = {"a": a, "b": b, "c": c};
    return composedEquotion;
  }

  Map<String, String> arithgene(
    key,
    level,
  ) {
    int t = level ~/ 3;
    print("generate arithquote");
    print("key:$key");
    print("level:$level and case:$t");

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
        rangNum = 10;
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
      case 4:
        calcNumAmt = 4;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/
            2; // 1-calcNumAmt~/2 random number of (),when there are two () , need two more symbol included
        rangNum = 100;
      default:
        calcNumAmt = 2;
        calcSymbolNum = 1; //
        calcparentheis = 0;
    }

    List calcSymbolPriority = [
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
      arithstring = "$a$str1$b=?";

      print("result:$calresult");
      print("arithstring:$arithstring");
      arithquote = {"result": calresult.toString(), "level1": arithstring};
    } else {
      print(
          "calcNun more than 2 : $calcNumAmt,() calcparentheis is less then calcNum-1: $calcparentheis");
      List composedEquation = [];
      for (int k = 0; k < numArray.length; k++) {
        composedEquation.add(numArray[k]);
        if (k < calcsymbolArray.length) {
          composedEquation.add(calcsymbolArray[k]);
        }
      }
      //compose the equation

      if (calcparentheis == 0 || Random().nextInt(calcparentheis + 1) == 0) {
        for (int l = 0; l <= composedEquation.length; l++) {
          if (l == 0) {
            arithstring = composedEquation[0].toString();
          } else if (l == composedEquation.length) {
            arithstring = "$arithstring=?";
          } else {
            arithstring += composedEquation[l].toString();
          }
        }
      } else {
        List pthpairs = ["(", ")"];
        int cmplth = composedEquation.length;
        int calcpthNum = randomGen(1, calcparentheis);
        int pthposit = 0;
        int tempPNI = calcNumAmt ~/ calcpthNum;
        int tempPNR = calcNumAmt % calcpthNum;
        int tmpnum = 0;

        print("composedEquation:$composedEquation");
        late int p;
        if (tempPNI == 2 && tempPNR == 0) {
          for (p = 0; p < 2; p++) {
            for (int i = 0; i < cmplth; i++) {
              composedEquation.insert(pthposit, pthpairs[p]);
            }
          }
        } else {
          //compose the equation begin
          for (int o = 1; o <= calcpthNum; o++) {
            print(
                "calcNumAmt:$calcNumAmt,,calcpthNum:$calcpthNum,,tempPNI:$tempPNI,,tempPNR:$tempPNR");
            tmpnum++;
            late int tmp;
            for (p = 0; p < 2; p++) {
              if (p == 0) {
                // pthposit = (pthposit + (Random().nextInt(tempPNI + tempPNR - 1)));
                tmp = tempPNI + tempPNR;
                pthposit = getEvebGen(0, tmp);
                print("pthposit1:$pthposit,,tmp:$tmp");
                composedEquation.insert(pthposit, pthpairs[p]);
              } else {
                int tmp4 = composedEquation.length;
                print("tmp4:$tmp4");

                if (tmp == 0) {
                  pthposit = 4;
                }
                if (tmp == 2) {
                  pthposit = 6;
                }

                print("pthposit2:$pthposit");
                if (pthposit < tmp4) {
                  composedEquation.insert(pthposit, pthpairs[p]);
                } else {
                  composedEquation.add(pthpairs[p]);
                }
              }
              print("tmpnum:$tmpnum");
              print("composedEquation$composedEquation");
            }
          }
        }
        //************ compose the equation end **************/
        for (int p = 0; p <= composedEquation.length; p++) {
          if (p == 0) {
            arithstring = composedEquation[0].toString();
          } else if (p == composedEquation.length) {
            arithstring = "$arithstring=?";
          } else {
            arithstring += composedEquation[p].toString();
          }
        }
      }
      int calresult = 0; //temp fixing
      arithquote = {"result": calresult.toString(), "level1": arithstring};
    }
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
