import 'dart:convert';
import 'dart:math';

late int a,
    b,
    c,
    calcNumAmt,
    calcSymbolNum,
    answer,
    rangNum,
    radomNumOfCalcSymbol,
    simbolcat,
    calcparentheis;
late String arithstring, str1, str2, str3;
String questionMark = '?';
late num answertmp;
bool calcend = false;
late Map<String, String> arithquote;
late Map<String, int> calresult;
late List composedEquation;

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
  Map<String, int> calcModule(
      num aa, num bb, String t, bool calcend, int index) {
    switch (t) {
      case "+":
        answertmp = aa + bb;
      case "-":
        answertmp = aa - bb;

      case "×":
        answertmp = aa * bb;
      case "÷":
        if (bb == 0) {
          print("bb dominator is 0, pls chk pgm");
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
      // print("totalNum:$numArray");
    }

    //get calc simbol involved into calc
    print("calcSymbolNum$calcSymbolNum");
    for (int i = 0; i < calcSymbolNum; i++) {
      calcsymbolArray.add(calcsymbol[Random().nextInt(simbolcat)]);
      // print("allCalcSimbol:$calcsymbolArray");
    }

    //get () simbol involved into calc
    print("Num of calcparentheis:$calcparentheis");
    if (calcNumAmt <= 2) {
      print("calcNun less than 2");
      a = Random().nextInt(rangNum);
      b = Random().nextInt(rangNum);
      str1 = calcsymbolArray[calcSymbolNum - 1];
      calresult = calcModule(a, b, str1, calcend, 1);
      a = calresult["a"]!;
      b = calresult["b"]!;
      arithstring = "";
    } else {
      print(
          "calcNum more than 2 : $calcNumAmt,() calcparentheis is less than calcNum-1: $calcparentheis");
      composedEquation = [];
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
      //************ compose the equation from list to string end**************/
      for (int p = 0; p <= composedEquation.length; p++) {
        if (p == 0) {
          arithstring = composedEquation[0].toString();
        } else if (p == composedEquation.length) {
          print("equation composed done");
          // arithstring = "$arithstring=?";
        } else {
          if (composedEquation[p] == "÷" && composedEquation[p + 1] == 0) {
            composedEquation[p + 1] = 1;
          }
          arithstring += composedEquation[p].toString();
        }
      }
      // calresult = {"calresult": 0};
    }

    //************ compose the equation end wiith =? **************/
    arithstring.isEmpty
        ? arithstring = "$a$str1$b=?"
        : arithstring = "$arithstring=?";

    //************ calc the number and get the actual equation start ****************
    print("final arithstring:$arithstring");
    //finding (
    List tmpCalcNumAll = [];
    List tmpCalcSimbolAll = [];

    List calcResult = [];
    List calcWIPd = [];
    bool calcPthend = false, calcPthInitend = false;
    int calcpath = 0,
        j = 0,
        k = 0,
        kk = 0,
        count = 0,
        countpth = 0,
        tmpcalcResult = 0,
        counti = 0;
    late int d;
    print("composedEquation:$composedEquation");
    for (int i = 0; i < composedEquation.length; i++) {
      if (composedEquation[i] == "(") {
        calcPthend = false;
        List calcWIP = [];
        List tmpCalc = []; // initialized tmpCalc
        // get the first (
        for (j = 1; j < composedEquation.length - i; j++) {
          if (composedEquation[i + j] != ")") {
            // get the ) and add all into list btw ()
            tmpCalc.add(composedEquation[i + j]);
            print("tmpCalc_):$tmpCalc");
          } else {
            // after get ) then switch to next () and add next the equation into list
            i = i + j;
            print("i+j:$i");
            //******** start the cycle () calc ********
            if (calcPthend == false) {
              // call '+', '-', '×', '÷' calc and add into list within ()
              counti = 0;
              int tmpret = 0, count1 = 0;
              for (d = 0; d < tmpCalc.length; d++) {
                var tmppp = tmpCalc[d];
                print("ddd:$d,,,,,tmppp:$tmppp");
                //call '×', '÷' and add into new list
                if (tmpCalc[d] == "×" || tmpCalc[d] == "÷") {
                  if (count1 == 0) {
                    if (tmpCalc[d] == "÷" && tmpCalc[d + 1] == 0) {
                      tmpCalc[d + 1] = 1;
                      print("d:::$d,,,i:::$i,,,");
                      composedEquation[count + d + 1] =
                          1; // change inner cycle denominator from 0 to 1
                      int www = composedEquation[count + d + 1],
                          qqq = count + d + 1;
                      print("composedEquation:$www,,,,qqq:$qqq");
                    }
                    Map<String, int> tmpresult1 = calcModule(
                        tmpCalc[d - 1], tmpCalc[d + 1], tmpCalc[d], false, 1);
                    int? tmpret = tmpresult1["calresult"];
                    print("_tmpret_bfr:$tmpret");
                    print("_1sttmpret_bfr_rmvD:$calcWIP");
                    print("counti:$counti");
                    calcWIP.removeAt(counti - 1);
                    print("_1sttmpret_aft_rmvD:$calcWIP");
                    calcWIP.add(tmpret);
                    calcPthInitend = true;
                    print("1sttmpret_after_add:$calcWIP");
                    count1 = count1 + 1;
                  } else {
                    if (tmpCalc[d] == "÷" && tmpCalc[d + 1] == 0) {
                      tmpCalc[d + 1] = 1;
                      composedEquation[count + d + 1] =
                          1; // change inner cycle denominator from 0 to 1
                    }
                    Map<String, int> tmpresult1 = calcModule(
                        tmpret, tmpCalc[d + 1]!, tmpCalc[d], false, 1);
                    tmpret = tmpresult1["calresult"]!;
                    print("tmpret_bfr:$tmpret");
                    print("tmpret_bfr_rmvD:$calcWIP");
                    print("counti_:$counti");
                    calcWIP.removeAt(counti - 1);
                    print("tmpret_aft_rmvD:$calcWIP");
                    calcWIP
                        .add(tmpret); // need to check and review all the calcs
                    calcPthInitend = true;
                    print("tmpret_after_add:$calcWIP");
                    count1 = count1 + 1;
                  }
// add into List for next calc cycle  :2-(12÷1×4)+3=?
                  countpth++;
                  d = d + 1;
                  print("calcWIP_y:$calcWIP");
                } else {
                  var tmpp = tmpCalc[d];
                  print(calcPthInitend);
                  print("dd:$d,,,,,tmpp:$tmpp");
                  if (calcPthInitend == true) {
                    calcWIP.add(tmpCalc[d]);
                    counti = counti + 1;
                    print("calcWIP-af-add:$calcWIP");
                  } else if (tmpCalc[d] == ")") {
                    break;
                  } else {
                    calcWIP.add(tmpCalc[d]);
                    counti = counti + 1;
                    print("calcWIP-aft-add:$calcWIP");
                  }
                  print(
                      "tmpCalc[d]:$tmpCalc"); // add into List for next calc cycle
                  print("calcWIP_n:$calcWIP");
                  if (tmpCalc[d] == "+" || tmpCalc[d] == "-") {
                    count1 = 0;
                  }
                } //
              }
              //  start () inner '+', '-' calc come out a new single answer within ()
              int tmpres2 = 0, count2 = 0;

              print("calcWIP_+-before:$calcWIP");
              if (calcWIP.contains("+") || calcWIP.contains("-")) {
                for (int dd = 0; dd < calcWIP.length; dd++) {
                  print(calcWIP.length);
                  print("dd_begin:$dd");
                  if (calcWIP[dd] == "+" || calcWIP[dd] == "-") {
                    if (tmpres2 == 0 && count2 == 0) {
                      Map<String, int> tmpresult2 = calcModule(calcWIP[dd - 1],
                          calcWIP[dd + 1], calcWIP[dd].toString(), true, 1);
                      tmpres2 = tmpresult2["calresult"]!;
                      print("tmpcalc2_1st:$tmpres2");
                      count2 = count2 + 1;
                    } else {
                      Map<String, int> tmpresult2 = calcModule(tmpres2,
                          calcWIP[dd + 1], calcWIP[dd].toString(), true, 1);
                      tmpres2 = tmpresult2["calresult"]!;
                      print("tmpcalc2_later:$tmpres2");
                      count2 = count2 + 1;
                    }
                    print("tmpcalc2_later_complete:$tmpres2");
                    print("dd_complete:$dd");
                  }
                  print("calcWIP_final:$calcWIP");
                }
                calcPthend = true;
                tmpCalcNumAll.add(tmpres2);
                print("tmpCalcNumAll-after+-:$tmpCalcNumAll");
                // calcPthend = true;
                print("tmpres2:$tmpres2");
              } else {
                tmpres2 = calcWIP[0];
                tmpCalcNumAll.add(tmpres2);
              }
              //*********** complete the cycle () equation calc ************
            }
            if (calcPthend == true) {
              tmpCalcSimbolAll.add(tmpCalc);
              print("tmpCalcSimbolAll:$tmpCalcSimbolAll");
            } // add all () equation into all list , pending on review to remove
            break; // escape inner compose and calc loop
          }
          calcpath++; // get () list donee
        }
        i = count + i;
      } else {
        print("iiiii:$i");
        print("tmpCalcNumAll-t-):$tmpCalcNumAll");
        print("calcPthend:$calcPthend");
        print("i:$i,,,,,,j:$j");
        if (calcPthend == true) {
          tmpCalcNumAll.add(composedEquation[i]);
          print("tmpCalcNumAll-f-):$tmpCalcNumAll");
        } else {
          tmpCalcNumAll.add(composedEquation[i]);
          print("tmpCalcNumAll-f-0:$tmpCalcNumAll");
        }
// add the each elements with nums only within composedEquation into new list
      }
      print("tmpCalcNumAll:::$tmpCalcNumAll");

      //*************** end complete calc numbers **********************/
    }
    //+++++++++++++++ start to calc all numbers ++++++++++++++++++++++
    if (tmpCalcNumAll.length == 1) {
      calresult = {"calresult": tmpCalcNumAll[0]};
    } else {
      List tmpCalc = []; // initialized tmpCalc
      int countii = 0, count3 = 0;
      print("tmpCalcNumAll_start_calc:$tmpCalcNumAll");
      int tempcalcdd = 0;
      bool tttttt = tmpCalcNumAll.contains("×");
      bool wwwwww = tmpCalcNumAll.contains("÷");
      print("tttttt:::$tttttt ,,,,,wwwwww:::$wwwwww");
      if (tmpCalcNumAll.contains("×") || tmpCalcNumAll.contains("÷")) {
        for (int ii = 0; ii < tmpCalcNumAll.length; ii++) {
          if (tmpCalcNumAll[ii] == "×" || tmpCalcNumAll[ii] == "÷") {
            var ppp = tmpCalcNumAll[ii];
            print("ppp::$ppp");
            if (tmpCalcNumAll[ii] == "÷" && tmpCalcNumAll[ii + 1] == 0) {
              // tmpCalc[ii + 1] = 1;
              print(
                  "Error exception on Calc - dominator is 0"); // return and regenerate the arith .

              // go to new generator please.. ***
              Map<String, String> arithquote = {"Errormsg": "Err-DomiZero"};
              return arithquote;
            }
            if (count3 == 0) {
              print("tempcalcdd_inner1-bfr:$tempcalcdd");
              Map<String, int> tmpresult1 = calcModule(tmpCalcNumAll[ii - 1],
                  tmpCalcNumAll[ii + 1]!, tmpCalcNumAll[ii], false, 1);
              tempcalcdd = tmpresult1['calresult']!;
              tmpCalc.removeAt(countii - 1);
              tmpCalc.add(tempcalcdd);
              count3 = count3 + 1;
              print("tempcalcdd_inner1:$tempcalcdd,,,,,tmpCalc:$tmpCalc");
            } else {
              print("tempcalcdd_inner2-bfr:$tempcalcdd");
              Map<String, int> tmpresult1 = calcModule(tempcalcdd,
                  tmpCalcNumAll[ii + 1], tmpCalcNumAll[ii], false, 1);
              tempcalcdd = tmpresult1['calresult']!;
              tmpCalc.removeAt(countii - 1);
              tmpCalc.add(tempcalcdd);
              count3 = count3 + 1;
              print("tempcalcdd_inner2:$tempcalcdd,,,,,tmpCalc:$tmpCalc");
            }
            print("tempcalcdd__:$tempcalcdd");
            ii = ii + 1;
          } else {
            var ooo = tmpCalcNumAll[ii];
            tmpCalc.add(tmpCalcNumAll[ii]);
            print(
                "tempcalcdd_else:$tempcalcdd,,,tmpCalc:$tmpCalc,,,,ooo:$tmpCalcNumAll[ii]");
            if (tmpCalcNumAll[ii] == "+" || tmpCalcNumAll[ii] == "-") {
              count3 = 0;
            }
            countii = countii + 1;
          }
        }
      } else {
        tmpCalc = tmpCalcNumAll;
        print("tempcalcdd has not × ÷");
      }

      print("tmpCalc-dd_×÷:$tmpCalc");

//calc all number +-
      int tempcalcdd2 = 0, count4 = 0;
      print("tmpCalcNumAll__end,,,:$tmpCalc");
      if (tmpCalc.contains("+") || tmpCalc.contains("-")) {
        for (int jj = 0; jj < tmpCalc.length; jj++) {
          print("jj:$jj");
          if (tmpCalc[jj] == "+" || tmpCalc[jj] == "-") {
            if (tempcalcdd2 == 0 && count4 == 0) {
              Map<String, int> tmpresult1 = calcModule(
                  tmpCalc[jj - 1], tmpCalc[jj + 1], tmpCalc[jj], false, 1);
              tempcalcdd2 = tmpresult1['calresult']!;
              count4 = count4 + 1;
            } else {
              Map<String, int> tmpresult1 = calcModule(
                  tempcalcdd2, tmpCalc[jj + 1], tmpCalc[jj], false, 1);
              tempcalcdd2 = tmpresult1['calresult']!;
              count4 = count4 + 1;
            }
            print("tempcalcdd2__:$tempcalcdd2");
          } else {
            var tttt = tmpCalc[jj];
            print("error msg:$tttt");
          }
        }
        print("tmpCalc-dd_+-_final:$tempcalcdd2");
        print("tempcalcdd_:$tempcalcdd2");
        calresult = {"calresult": tempcalcdd2};
      } else {
        tempcalcdd2 = tempcalcdd;
        print("tempcalcdd2:$tempcalcdd2");
        calresult = {"calresult": tempcalcdd2};
      }
    }
    //**************** complete full calc  *********************/

    print("tmpCalcAll:$tmpCalcSimbolAll");
    print("tmpCalcNumAll_end:$tmpCalcNumAll");

    //calc end

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
