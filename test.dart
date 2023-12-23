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
    simbolcat,
    calcparentheis;
late String arithstring, str1, str2, str3;
String questionMark = '?';
late num answertmp;
bool calcend = false;
late Map<String, String> arithquote;
late Map<String, int> calresult;

const List uniqNum = [1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
const List calcsymbol = ['+', '-', '×', '÷', '()'];

Future<void> main() async {
  // for (int i = 0; i < 100; i++) {
  //   // print(i);
  //   print(getEvebGen(6, 8));
  //   // print((randomGen(1, 9)));
  // }

  for (int q = 0; q < 50; q++) {
    var result = await arith().getArith("1", 15, 9, "test");
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

randomEvebGen(min, max) {
  List tmp = [];
  int u = 0;
  // print("aaa:$min,,,bbb:$max,,,u:$u");
  for (int i = min; i <= max; i++) {
    if (i.isEven) {
      tmp.add(i);
      u++;
    }
  }
  var z = tmp[Random().nextInt(u)];
  // print("z:$z");
  return z;
}

randomOddGen(min, max) {
  List tmp = [];
  int u = 0;
  // print("aaa:$min,,,bbb:$max,,,u:$u");
  for (int i = min; i <= max; i++) {
    if (i.isOdd) {
      tmp.add(i);
      u++;
    }
  }
  var z = tmp[Random().nextInt(u)];
  // print("z:$z");
  return z;
}

//util end

class arith {
  // calc the minimum equation
  Map<String, int> calcModule(num aa, num bb, String t, bool calcend) {
    switch (t) {
      case "+":
        answertmp = aa + bb;
      case "-":
        answertmp = aa - bb;
      // if (answertmp < 0) {
      //   print("abstract answer is nagetive");
      //   num aatmp = aa;
      //   aa = bb;
      //   bb = aatmp;
      //   answertmp = -answertmp;
      // }
      case "×":
        answertmp = aa * bb;
      case "÷":
        if (bb == 0) {
          bb = 1;
        }
        answertmp = (aa ~/ bb);
      case "(":
      case "<":
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
        simbolcat = 2;
        rangNum = 10;
      case 1:
        calcNumAmt = 3; //2-3 pick numbers of number
        calcSymbolNum = calcNumAmt -
            1; // can have ()  symbol without () ,must with nums of num minius 1.
        calcparentheis = calcNumAmt ~/ 2; // 1-calcNumAmt~/2 random number of ()
        simbolcat = 3;
        rangNum = 10;
      case 2:
        calcNumAmt = 3;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/ 2; // 0-calcNumAmt~/2 random number of ()
        simbolcat = 3;
        rangNum = 10;
      case 3:
        calcNumAmt = 4;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/ 2; // 0-calcNumAmt~/2 random number of ()
        simbolcat = 4;
        rangNum = 10;
      case 4:
        calcNumAmt = 4;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/
            2; // 1-calcNumAmt~/2 random number of (),when there are two () , need two more symbol included
        simbolcat = 4;
        rangNum = 15;
      case 5:
        calcNumAmt = 5;
        calcSymbolNum = calcNumAmt - 1; //2-(calcNumAmt-1)
        calcparentheis = calcNumAmt ~/
            2; // 1-calcNumAmt~/2 random number of (),when there are two () , need two more symbol included
        simbolcat = 4;
        rangNum = 15;
      default:
        calcNumAmt = 2;
        calcSymbolNum = 1; //
        calcparentheis = 0;
    }

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
      calcsymbolArray.add(calcsymbol[Random().nextInt(simbolcat)]);
      print("allCalcSimbol:$calcsymbolArray");
    }

    //get () simbol involved into calc
    print("Num of calcparentheis:$calcparentheis");
    if (calcNumAmt <= 2) {
      print("calcNun less than 2");
      a = Random().nextInt(rangNum);
      b = Random().nextInt(rangNum);
      str1 = calcsymbolArray[calcSymbolNum - 1];
      calresult = calcModule(a, b, str1, calcend);
      arithstring = "";
    } else {
      print(
          "calcNum more than 2 : $calcNumAmt,() calcparentheis is less than calcNum-1: $calcparentheis");
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
            print("equation composed");
          } else {
            arithstring += composedEquation[l].toString();
          }
        }
        print("level1:$arithstring");
      } else {
        List pthpairs = ["(", ")"];
        int cmplth = composedEquation.length;
        int calcpthNum = randomGen(1, calcparentheis);
        int pthposit = 0;
        int tempPNI = calcNumAmt ~/ calcpthNum;
        int tempPNR = calcNumAmt % calcpthNum;
        int tmpnum = 0;

        print("composedEquation:$composedEquation");
        //compose the equation begin
        pthposit = 0;
        print("pthposit_init:$pthposit");
        for (int o = 1; o <= calcpthNum; o++) {
          int p = 0;
          print(
              "calcNumAmt:$calcNumAmt,,calcpthNum:$calcpthNum,,tempPNI:$tempPNI,,tempPNR:$tempPNR");
          tmpnum++;
          late int tmp;
          for (p = 0; p < 2; p++) {
            if (p == 0) {
              // pthposit = (pthposit + (Random().nextInt(tempPNI + tempPNR - 1)));
              tmp = (calcNumAmt + calcSymbolNum - 1) -
                  (3 * (calcpthNum - o) + (calcpthNum - o));

              print("tmp_before:$tmp");
              if (tempPNI == 2 && tempPNR == 0 && o == 1) {
                pthposit = 0;
              } else {
                pthposit == 0
                    ? pthposit = randomEvebGen(0, tmp - 2)
                    : pthposit = pthposit + 2;
              }
              print("pthposit1:$pthposit,,tmp:$tmp");
              composedEquation.insert(pthposit, pthpairs[p]);
            } else {
              int tmplength = composedEquation.length;
              int tmp4 = tmplength - (3 * (calcpthNum - o) + (calcpthNum - o));
              print("tmplength:$tmplength,,,pthposit:$pthposit,,,tmp4:$tmp4");
              if (tmp4 < (pthposit + 3)) {
                print("the ) is wrongly ahead of next () ");
              } else {
                print("pthposit_before:$pthposit");
                int tmp5 = pthposit + 4;
                print("tmp5_before:$tmp5,,,tmp4_before:$tmp4");
                pthposit = randomEvebGen(tmp5, tmp4);
                print("pthposit_tmp5:$pthposit,,tmp4:$tmp4");
                if (pthposit < tmplength) {
                  composedEquation.insert(pthposit, pthpairs[p]);
                } else {
                  composedEquation.add(pthpairs[p]);
                }
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
          print("equation composed done");
          // arithstring = "$arithstring=?";
        } else {
          arithstring += composedEquation[p].toString();
        }
      }
      calresult = {"calresult": 0};
    }
    arithstring.isEmpty
        ? arithstring = "$a$str1$b=?"
        : arithstring = "$arithstring=?";
    //calc the number and get the actual equation
    print("final arithstring:$arithstring");
    //finding (
    List tmp = [];

    for (int i = 0; i < arithstring.length; i++) {
      if (arithstring[i] == "(") {}
    }

    //calc end
    if (calresult['calresult'].toString() == "") {
      Map<String, int> calresult = {"calresult": 0};
    }
    arithquote = {
      "result": calresult["calresult"].toString(),
      "level1": arithstring
    };
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
