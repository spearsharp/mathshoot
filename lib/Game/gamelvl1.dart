import 'dart:ffi';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'dart:async';
import 'dart:math';
import '../routers/routers.dart';
import '../Game/gamelvl2.dart';
import '../services/screeenAdapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/localStorage.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'services/arith.dart';

class GameLvl1 extends StatefulWidget {
  final Map arguments;
  const GameLvl1({super.key, required this.arguments});

  @override
  State<GameLvl1> createState() => _GameLvl1State();
}

class _GameLvl1State extends State<GameLvl1> {
  late bool levelup;
  bool levelkeep = true, gamestart = false, counddown = false;
  int currentlevel = 0;
  // final player = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audiocache = AudioCache(); //and this

  final StreamController<int> _inputController =
      StreamController.broadcast(); //multiple listener
  final StreamController<int> _scoreController = StreamController.broadcast();
  // final StreamController<int> _levelController = StreamController.broadcast();
  var _assetAudioPlay = AssetsAudioPlayer.newPlayer();
  int score = 0;
  int level = 1;
  int baloonAmt = 1;
  int durationTime = Random().nextInt(5000) + 5800;

  @override
  void initState() {
    //setting background picture and popup message

    super.initState();
    print(widget.arguments);

    void gamekickoff() {}

    _assetAudioPlay.open(
      // local audio play , assetsaudioplayer
      Audio("audios/9346.wav"),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );
  }

  void audioStop() {
    _assetAudioPlay.stop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width;
    print("screenHeight: $screenHeight");
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: StreamBuilder(
              stream: _scoreController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (score >= 0) {
                    score += snapshot.data as int;
                    // if (score > 20) {  / route to game level 2
                    //   print("level up");
                    //   audioStop();
                    //   Navigator.of(context)
                    //       .push(MaterialPageRoute(builder: (context) {
                    //     return GameLvl2(
                    //       arguments: {score: score},
                    //     );
                    //   }));
                    // }
                    if (score < 0) {
                      score = 0;
                      print("Game Over");
                    }
                  } else {
                    score = 0;
                  }
                  // localStorage.setData("levelName", level);
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text("score： $score",
                            style: const TextStyle(
                                fontFamily: 'PWBalloon',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: screenWidth,
                        ),
                        // Text(
                        //   "level： $level",
                        // )
                      ],
                    ));
              }),
        ),
        body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/game/bgpic1.jpeg"))),
            child: Stack(
              children: [
                // clevel = localStorage.getData("levelName"),
                // Text("Children level: $clevel"),
                ...List.generate(10, (index) {
                  print("durationTime:: $durationTime");
                  // generate numbers of baloon
                  if (gamestart) {
                    return Game(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      inputController: _inputController,
                      scoreController: _scoreController,
                      // levelController: _levelController,
                    );
                  } else {
                    return Text("");
                  }
                }),
                // localStorage.removeData("levelName"),
                KeyPad(inputController: _inputController),
                //tap to kickoff game, level1
                gamestart
                    ? const Text("")
                    : Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                      height: screenHeight * 0.4,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            alignment: Alignment.topCenter,
                                            image: AssetImage(
                                                "images/game/animated6balloontitleformpic.gif")),
                                      ),
                                      child: const Align(
                                          alignment: Alignment(0, 0.85),
                                          child: Text(
                                            "level 1",
                                            style: TextStyle(
                                              fontSize: 36.0,
                                              color: Color.fromARGB(
                                                  255, 92, 51, 1),
                                              decorationStyle:
                                                  TextDecorationStyle.dashed,
                                              letterSpacing: 5.0,
                                              fontFamily: 'Balloony',
                                            ),
                                          ))),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    counddown = true;
                                    gamestart = true;
                                  });
                                },
                                child: const Image(
                                    width: 280,
                                    height: 80,
                                    image: AssetImage(
                                      "images/game/animatednextpic.gif",
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                Positioned(
                    top: screenHeight * 0.055,
                    right: -30,
                    child: InkWell(
                        onTap: () {
                          print("topup money");
                        },
                        child: Container(
                          width: 100,
                          child: const Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Image(
                                    image: AssetImage(
                                        "images/game/icon/goldcoin.png"),
                                  )),
                              Expanded(
                                flex: 4,
                                child: Text(
                                    "123", // pending on topup fuunction, show the balancef
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'MotleyForces',
                                        color: Colors.blueGrey)),
                              )
                            ],
                          ),
                        ))),
              ],
            )));
  }
}

//Arithmatic game section
class Game extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final StreamController<int> inputController;
  final StreamController<int> scoreController;
  // final StreamController<int> levelController;
  const Game({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inputController,
    required this.scoreController,
    // required this.levelController,
  });
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  //call arith module

  late double x;
  late int a, b, c, d, e, f, g, netscore, levelevent;
  late Color color;
  late bool t, l;
  int durationTime = Random().nextInt(5000) + 5800;
  String m = '()';
  String n = '/';
  late AnimationController _animationController;

//game level started

//game restart
  reset(screenWidth) {
    // var arithRes = arithCalcSentence(){};   // insert arith
    t = true;
    d = Random().nextInt(5) + 1;
    e = Random().nextInt(5);
    x = Random().nextDouble() * screenWidth * 0.7;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  // levelup(level) {
  //   int speed = (5000 + 5000 / 2 * level) as int;
  //   return speed;
  // }

//level up and awearded

  //score update
  score(t) {
    if (t) {
      widget.scoreController.add(-1);
      netscore = netscore - 1;
      if (netscore < 0) {
        l = false;
        netscore = 0;
      }
    } else {
      widget.scoreController.add(3);
      netscore = netscore + 3;
      if (netscore > 10) {
        l = true;
        netscore = 0;
      }
    }
  }

  // level(bool l) {
  //   // print("levelevent : ${levelevent}");
  //   if (l == true) {
  //     widget.levelController.add(1);
  //   } else if (l == false && levelevent > 1) {
  //     widget.levelController.add(-1);
  //   }
  // }

  // ignore: non_constant_identifier_names
  ListView _UpdatePic(t, d, e) {
    if (t) {
      // print("气球图");
      return ListView(children: [
        Container(
            color: Colors.red.withOpacity(0),
            child: const Image(image: AssetImage("images/game/1balloon.png"))),
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text("$d+$e=?", style: const TextStyle(fontSize: 18))),
      ]);
    } else {
      // print("爆炸图");
      t = true;
      return ListView(children: [
        Container(
            color: Colors.red.withOpacity(0),
            child: const Image(
              image: AssetImage("images/game/smogbomb.gif"),
              fit: BoxFit.contain,
            )),
      ]);
    }
  }

  @override
  void initState() {
    a = Random().nextInt(99);
    b = Random().nextInt(99);
    c = Random().nextInt(9);
    late int speed;
    netscore = 0;
    super.initState();

    // game started
    reset(widget.screenWidth); //first round to play

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationTime));
    _animationController.forward();
    widget.inputController.stream.listen((event) {
      int total = d + e;
      print("d:: $d");
      print("e:: $e");
      print("event:: $event");

      if (total == event) {
        t = false;
        score(t);
        // level(l);
        setState(() {
          _UpdatePic(t, d, e);
          reset(widget.screenWidth);
          _animationController.forward(from: 0.0);
        });
      }
    });
    _animationController.addStatusListener((status) {
      //listening KeyPad press

      if (status == AnimationStatus.completed) {
        t = false;
        score(t);
        reset(widget.screenWidth);
        _animationController.forward(from: 0.0);
      }
      //get inputController data,and monitorring
    });
    //game complete
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
              top: Tween(begin: screenHeight * 0.6, end: -screenHeight * 0.3)
                  .animate(_animationController)
                  .value,
              left: x,
              child: Container(
                  // decoration: ,
                  color: Colors.red.withOpacity(0),
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.3,
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: _UpdatePic(t, d, e)));
        });
  }
}

//keypad monitorring
class KeyPad extends StatelessWidget {
  final StreamController<int> inputController;
  const KeyPad({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {2
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          // color: Colors.red,
          child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: 5 / 4,
        children: List.generate(10, (index) {
          // Delete key add
          return TextButton(
              style: ButtonStyle(
                  shape:
                      MaterialStateProperty.all(const RoundedRectangleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.primaries[index][300]),
                  foregroundColor: MaterialStateProperty.all(Colors.black45)),
              onPressed: () {
                inputController.add(index);
              },
              child: Text("$index",
                  style: Theme.of(context).textTheme.headlineMedium));
        }),
      )),
    );
  }
}
