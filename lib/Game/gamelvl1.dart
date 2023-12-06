import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Gamelvl1Stage extends StatefulWidget {
  final int level;
  const Gamelvl1Stage(
      {super.key,
      required this.level,
      required int durationTime,
      required StreamController<int> inputController,
      required StreamController<int> scoreController,
      required StreamController<int> levelController});

  @override
  State<Gamelvl1Stage> createState() => _Gamelvl1StageState();
}

class _Gamelvl1StageState extends State<Gamelvl1Stage> {
  late int level;
  late int currentlevel;
  @override
  void initState() {
    super.initState();
    level = widget.level;
    currentlevel = level;
    print("widget level : $widget.level");
    print("init level : $currentlevel");
  }

  late bool levelup;
  bool levelkeep = true;
  final StreamController<int> _inputController =
      StreamController.broadcast(); //multiple listener
  final StreamController<int> _scoreController = StreamController.broadcast();
  final StreamController<int> _levelController = StreamController.broadcast();

  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: StreamBuilder(
              stream: _scoreController.stream,
              builder: (context, snapshot) {
                // if (currentlevel != level) {}
                // currentlevel = level;
                if (snapshot.hasData) {
                  if (score >= 0) {
                    score += snapshot.data as int;
                    if (score < 0) {
                      score = 0;
                    }
                  } else {
                    score = 0;
                  }
                  if (level >= 1) {
                    level = (score ~/ 10);
                    if (level > currentlevel) {
                      levelup = true;
                      currentlevel = level;
                      print("level:$level");
                      print("currentLevel:$currentlevel");
                      print("levelup:$levelup");
                      Fluttertoast.showToast(msg: "levelup successfuul");
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) {
                      //   return Gamelvl2Stage(level: currentlevel + 1);
                      // }));
                    } else if (level < currentlevel) {
                      levelup = false;
                      currentlevel = level;
                      print("level:$level");
                      print("currentLevel:$currentlevel");
                      print("leveldown:$currentlevel");
                      Fluttertoast.showToast(msg: "levelup failed");
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) {
                      //   return GameStage(level: currentlevel - 1);
                      // }));
                    } else if (level == currentlevel) {
                      levelkeep = true;
                    } else {
                      levelkeep = false;
                      print("level up/down error");
                    }
                    if (level < 1) {
                      level = 1;
                    }
                  } else {
                    level = 1;
                  }
                  // localStorage.setData("levelName", level);
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text("您的得分： $score"),
                        Text(
                          "关卡： $level",
                        )
                      ],
                    ));
              }),
        ),
        body: levelkeep
            ? Stack(
                children: [
                  // clevel = localStorage.getData("levelName"),
                  // Text("Children level: $level"),
                  // Text("Children level: $levelkeep"),
                  ...List.generate(level, (index) {
                    return Game(
                        inputController: _inputController,
                        scoreController: _scoreController,
                        levelController: _levelController);
                  }),
                  // localStorage.removeData("levelName"),
                  KeyPad(inputController: _inputController)
                ],
              )
            : levelup
                ? Stack(
                    children: [
                      // clevel = localStorage.getData("levelName"),
                      // Text("Children level: $clevel"),
                      ...List.generate(level + 1, (index) {
                        return Game(
                            inputController: _inputController,
                            scoreController: _scoreController,
                            levelController: _levelController);
                      }),
                      // localStorage.removeData("levelName"),
                      KeyPad(inputController: _inputController)
                    ],
                  )
                : Stack(
                    children: [
                      // clevel = localStorage.getData("levelName"),
                      // Text("Children level: $clevel"),
                      ...List.generate(level - 1, (index) {
                        return Game(
                            inputController: _inputController,
                            scoreController: _scoreController,
                            levelController: _levelController);
                      }),
                      // localStorage.removeData("levelName"),
                      KeyPad(inputController: _inputController)
                    ],
                  ));
  }
}

// Future<void> saveData(int level) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setInt("CurrentLevel", level);
// }

// Future<int?> fetchData() async {
//   final prefs = await SharedPreferences.getInstance();
//   Future<int?> clevel;
//   // ignore: unrelated_type_equality_checks
//   if (prefs.getInt("CurrentLevel") == "") {
//     clevel = 0 as Future<int?>;
//     print("Currentlevel is  null: $clevel");
//   } else {
//     clevel = prefs.getInt("CurrentLevel") as Future<int?>;
//     print("Currentlevel is not null: $clevel");
//   }
//   return clevel;
// }

//Arithmatic game section
class Game extends StatefulWidget {
  final StreamController<int> inputController;
  final StreamController<int> scoreController;
  final StreamController<int> levelController;
  const Game(
      {super.key,
      required this.inputController,
      required this.scoreController,
      required this.levelController});
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  late double x;
  late int a, b, c, d, e, f, g, netscore, levelevent;
  late Color color;
  late bool t, l;
  String m = '()';
  String n = '/';
  late AnimationController _animationController;

//game restart
  reset() {
    t = true;
    d = Random().nextInt(5) + 1;
    e = Random().nextInt(5);
    x = Random().nextDouble() * 320;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  // levelup(level) {
  //   int speed = (5000 + 5000 / 2 * level) as int;
  //   return speed;
  // }

  //score update
  score(t) {
    if (t) {
      widget.scoreController.add(3);
      netscore = netscore + 3;
      if (netscore > 10) {
        l = true;
        netscore = 0;
      }
    } else {
      widget.scoreController.add(-1);
      netscore = netscore - 1;
      if (netscore < 0) {
        l = false;
        netscore = 0;
      }
    }
  }

  level(bool l) {
    // print("levelevent : ${levelevent}");
    if (l == true) {
      widget.levelController.add(1);
    } else if (l == false && levelevent > 1) {
      widget.levelController.add(-1);
    }
  }

//level up and awearded

  @override
  void initState() {
    a = Random().nextInt(99);
    b = Random().nextInt(99);
    c = Random().nextInt(9);
    late int speed;
    netscore = 0;
    super.initState();

    reset(); //first round to play
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: Random().nextInt(5000) + 5000));
    _animationController.forward();
    _animationController.addStatusListener((status) {
      //listening KeyPad press

      if (status == AnimationStatus.completed) {
        t = false;
        score(t);
        reset();
        _animationController.forward(from: 0.0);
      }
      //get inputController data,and monitorring
      widget.inputController.stream.listen((event) {
        int total = d + e;
        if (total == event) {
          t = true;
          score(t);
          // level levelup or leveldown check
          level(l);
          reset();
          _animationController.forward(from: 0.0);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width;
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Positioned(
              top: Tween(begin: -10.00, end: 500.00)
                  .animate(_animationController)
                  .value,
              left: x,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(18)),
                  child:
                      // ignore: unnecessary_brace_in_string_interps
                      Text("$d+$e=?", style: const TextStyle(fontSize: 18))));
        });
  }
}

//keypad monitorring
class KeyPad extends StatelessWidget {
  final StreamController<int> inputController;
  const KeyPad({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    List _keyPadList = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
      '.',
      '↵'
    ]; // keyboard with special input
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          // color: Colors.red,
          child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 5 / 2,
        children: List.generate(12, (index) {
          return TextButton(
              style: ButtonStyle(
                  shape:
                      MaterialStateProperty.all(const RoundedRectangleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.primaries[index][300]),
                  foregroundColor: MaterialStateProperty.all(Colors.black45)),
              onPressed: () {
                inputController.add(_keyPadList[index]);
                print("$_keyPadList[index]");
              },
              child: Text("$_keyPadList[index]",
                  style: Theme.of(context).textTheme.headlineMedium));
        }),
        // children: List.generate(12, (index) {
        //   return TextButton(
        //       style: ButtonStyle(
        //           shape:
        //               MaterialStateProperty.all(const RoundedRectangleBorder()),
        //           backgroundColor:
        //               MaterialStateProperty.all(Colors.primaries[index][300]),
        //           foregroundColor: MaterialStateProperty.all(Colors.black45)),
        //       onPressed: () {
        //         inputController.add(index + 1);
        //       },
        //       child: Text("${index + 1}",
        //           style: Theme.of(context).textTheme.headlineMedium));
        // }),
      )),
    );
  }
}
