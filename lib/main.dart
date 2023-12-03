import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'dart:async';
import 'dart:math';
import 'services/screeenAdapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/localStorage.dart';
import 'Game/game.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flatter Game",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool levelup;
  bool levelkeep = true;
  int currentlevel = 0;
  // final player = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audiocache = AudioCache(); //and this

  final StreamController<int> _inputController =
      StreamController.broadcast(); //multiple listener
  final StreamController<int> _scoreController = StreamController.broadcast();
  final StreamController<int> _levelController = StreamController.broadcast();

  int score = 0;
  int level = 1;
  int durationTime = Random().nextInt(5000) + 5000;
//BGM playing https://www.jianshu.com/p/9086e7343dc1  https://cloud.tencent.com/developer/ask/sof/703303  https://cloud.tencent.com/developer/ask/sof/106209149
  // _LoadMusic() async {
  //   print("test for background playing");
  //   await audioPlayer.play(UrlSource(
  //       'https://img3.tukuppt.com/newpreview_music/09/01/62/5c89fd22dea6948307.mp3'));
  //   //   // await audiocache.loadPath('audios/eM01.mp3');
  // }

  @override
  void initState() {
    super.initState();
    // audioPlayer.play(UrlSource(
    //     'https://img3.tukuppt.com/newpreview_music/09/01/62/5c89fd22dea6948307.mp3'));
    // audioPlayer.setReleaseMode(ReleaseMode.loop);

    AssetsAudioPlayer.newPlayer().open(
      Audio("audios/eM01.mp3"),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );
    // ignore: invalid_use_of_visible_for_testing_member
    // load: AudioPlayer()..setReleaseMode(ReleaseMode.loop));
  }

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
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GameStage(level: currentlevel + 1);
                      }));
                    } else if (level < currentlevel) {
                      levelup = false;
                      currentlevel = level;
                      print("level:$level");
                      print("currentLevel:$currentlevel");
                      print("currentlevelup:$currentlevel");
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GameStage(level: currentlevel - 1);
                      }));
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
                  // Text("Children level: $clevel"),
                  ...List.generate(level, (index) {
                    return Game(
                        durationTime: durationTime,
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
                            durationTime: durationTime,
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
                            durationTime: durationTime,
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
  final int durationTime;
  final StreamController<int> inputController;
  final StreamController<int> scoreController;
  final StreamController<int> levelController;
  const Game(
      {super.key,
      required this.durationTime,
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
  late int durationTime;
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
    durationTime = widget.durationTime;
    late int speed;
    netscore = 0;
    super.initState();

    reset(); //first round to play
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationTime));
    _animationController.forward();
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
    _animationController.addStatusListener((status) {
      //listening KeyPad press

      if (status == AnimationStatus.completed) {
        t = false;
        score(t);
        reset();
        _animationController.forward(from: 0.0);
      }
      //get inputController data,and monitorring
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          // color: Colors.red,
          child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 5 / 2,
        children: List.generate(9, (index) {
          return TextButton(
              style: ButtonStyle(
                  shape:
                      MaterialStateProperty.all(const RoundedRectangleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.primaries[index][300]),
                  foregroundColor: MaterialStateProperty.all(Colors.black45)),
              onPressed: () {
                inputController.add(index + 1);
              },
              child: Text("${index + 1}",
                  style: Theme.of(context).textTheme.headlineMedium));
        }),
      )),
    );
  }
}
