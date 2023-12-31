import 'dart:ffi';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
import '../model/keyPad.dart';
// import 'services/arith.dart';

class GameLvl1 extends StatefulWidget {
  final Map arguments;
  const GameLvl1({super.key, required this.arguments});

  @override
  State<GameLvl1> createState() => _GameLvl1State();
}

class _GameLvl1State extends State<GameLvl1> {
  late bool levelup;
  bool levelkeep = true, gamestart = false, countdown = false;
  List arrowLocation = [
    {"x": 0.1},
    {"Y": 0.2}
  ];
  int currentlevel = 0;
  // final player = AudioPlayer();
  final _assetAudioPlayer = AssetsAudioPlayer();
  final _keyAudioPlayer = AssetsAudioPlayer();

  final StreamController<int> _inputController =
      StreamController.broadcast(); //multiple listener
  final StreamController<int> _scoreController = StreamController.broadcast();
  final StreamController<List> _arrowController = StreamController.broadcast();
  // final StreamController<int> _levelController = StreamController.broadcast();
  var _assetAudioPlay = AssetsAudioPlayer.newPlayer();
  int score = 0;
  int level = 1;
  int baloonAmt = 1;
  int durationTime = Random().nextInt(5000) + 5800;

  @override
  void initState() {
    //setting background picture and popup message and BGM
    _assetAudioPlay.open(
      Audio("audios/level1_BGM.mp3"),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );

    super.initState();
    print(widget.arguments);

    void gamekickoff() {}
  }

  void keypresssound() {
    _keyAudioPlayer.open(Audio('audios/pressmobilekeyBGM.wav'),
        autoStart: true, loopMode: LoopMode.none);
  }

  void audioStop() {
    _assetAudioPlay.stop();
  }

  @override
  void dispose() {
    super.dispose();
    _assetAudioPlay.stop();
    _keyAudioPlayer.stop();
  }

  Future<bool> _loadingcountdownpic() {
    // loading countdown animated pic
    return Future(() => Future.delayed(const Duration(seconds: 2)));
  }

  countdownpicload() async* {
    // set gamestart to true and kickoff the game
    await _loadingcountdownpic()
        .then((value) => print(value))
        .whenComplete(() => setState(() {
              countdown = false;
              gamestart = true;
            }));
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
                                fontWeight: FontWeight.bold,
                                fontSize: 28)),
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
                  if (gamestart && !countdown) {
                    return Game(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      inputController: _inputController,
                      scoreController: _scoreController,
                      arrowControlloer: _arrowController,
                      // levelController: _levelController,
                    );
                  } else {
                    return Text("");
                  }
                }),
                // localStorage.removeData("levelName"),
                countdown //use streambuilder to rewrite the component
                    ? Center(
                        child: Container(
                            alignment: Alignment.center,
                            height: screenHeight * 0.4,
                            child: const Image(
                                image: AssetImage(
                                    "images/game/animatedreadygo.gif"))))
                    : const Text(""),
                gamestart
                    ? KeyPad(
                        inputController: _inputController,
                        screenWidth: screenWidth)
                    : countdown
                        ? KeyPad(
                            inputController: _inputController,
                            screenWidth: screenWidth)
                        : const Text(""),
                //tap to kickoff game, level1

                gamestart
                    ? const Text("")
                    : countdown
                        ? Text("")
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
                                                      TextDecorationStyle
                                                          .dashed,
                                                  letterSpacing: 5.0,
                                                  fontFamily: 'Balloony',
                                                ),
                                              ))),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        countdown = true;
                                        _loadingcountdownpic();
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
                    // full screen with topup money
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
                                        "images/game/icon/goldcoinpic.png"),
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
  final StreamController<List> arrowControlloer;
  // final StreamController<int> levelController;
  const Game({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inputController,
    required this.scoreController,
    required this.arrowControlloer,
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
  late bool t, l, accbalance;
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
      //pending update input display and flag to route.
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

//arrow shooting and animation
class arrowshoot extends StatefulWidget {
  final List arrowlocation;
  final double screenWidth, screenHeight;
  final StreamController<List> arrowControlloer;
  const arrowshoot(
      {super.key,
      required this.arrowControlloer,
      required this.screenWidth,
      required this.screenHeight,
      required this.arrowlocation});

  @override
  State<arrowshoot> createState() => _arrowshootState();
}

class _arrowshootState extends State<arrowshoot>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowcontroller;
  late double initscreenHeight, initscreenWidth;
  late List arrowlocation;

  @override
  void initState() {
    super.initState();
    final AnimationController _arrowcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    initscreenHeight = widget.screenHeight * 0.18;
    initscreenWidth = widget.screenWidth * 0.45;
    arrowlocation = widget.arrowlocation;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        // pending on variable injection via balloon position
        position: _arrowcontroller.drive(Tween(
            begin: Offset(initscreenHeight, initscreenWidth),
            end: Offset(arrowlocation[1], arrowlocation[2]))),
        child: Container(
          width: widget.screenWidth * 0.14,
          height: widget.screenHeight * 0.1,
          child: Transform.rotate(
              angle: 80.1,
              child: const Image(
                  image: AssetImage(
                      "images/game/arrow.png"))), // angle is changing along with animation
        ));
  }
}
//keypad monitorring

class KeyPad extends StatefulWidget {
  final StreamController<int> inputController;
  final double screenWidth;
  const KeyPad(
      {super.key, required this.inputController, required this.screenWidth});

  @override
  State<KeyPad> createState() => _KeyPadState();
}

//keypad function , pending on substract independently
class _KeyPadState extends State<KeyPad> {
  String displayPressNum = "";
  late String inputNum;
  bool sign = true, correctanswer = false;
  int presscount = 0;
  List<Widget> keyBoard(double t, int v) {
    List Keypad = [
      {"name": "0", "value": 0},
      {"name": "1", "value": 1},
      {"name": "2", "value": 2},
      {"name": "3", "value": 3},
      {"name": "4", "value": 4},
      {"name": "5", "value": 5},
      {"name": "6", "value": 6},
      {"name": "7", "value": 7},
      {"name": "8", "value": 8},
      {"name": "9", "value": 9},
      {"name": "+/-", "value": 10},
      {"name": "Del", "value": 11},
    ];
    List<Widget> tmplist = [];
    for (var i = 0; i < 12; i++) {
      var keytext = Keypad[i]["name"];
      var keyvalue = Keypad[i]["value"];
      tmplist.add(TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
              backgroundColor:
                  MaterialStateProperty.all(Colors.primaries[i][300]),
              foregroundColor: MaterialStateProperty.all(Colors.black45)),
          onPressed: () {
            if (displayPressNum.length < 5) {
              switch (keyvalue) {
                case 10:
                  {
                    print("displayPressNum.substring(0, 1)");
                    print(displayPressNum.substring(0, 1));
                    if (displayPressNum.substring(0, 1) == "-") {
                      displayPressNum =
                          displayPressNum.substring(1, displayPressNum.length);
                    } else {
                      displayPressNum = "-" + displayPressNum;
                    }

                    print("displayPressNum:$displayPressNum");
                    //pending on checking answer
                  }
                case 11:
                  {
                    displayPressNum = displayPressNum.substring(
                        0, displayPressNum.length - 1);
                    print("displayPressNum:$displayPressNum");
                    //pending on checking answer
                  }
                default:
                  {
                    displayPressNum = displayPressNum + keyvalue.toString();
                    //pending on checking answer
                  }
              }
              //check answers correction ,get return
              if (correctanswer == true) {
                displayPressNum = "";
                print("displayPressNum:$displayPressNum");
              }
            } else {
              presscount = 0;
              displayPressNum = "";
            }
            setState(() {
              inputNum = displayPressNum;
            });
            widget.inputController.add(keyvalue);
          },
          child: AutoSizeText("$keytext",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              minFontSize: 20,
              maxFontSize: 100,
              stepGranularity: 10,
              style:
                  const TextStyle(fontFamily: "MotleyForces", fontSize: 80))));
    }
    return tmplist;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width;
    return Stack(alignment: Alignment.center, children: [
      Positioned(
          left: 0.3 * screenWidth,
          right: 0.3 * screenWidth,
          top: 0.5 * screenHeight,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(3, 2, 2, 3),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Text(
              "$displayPressNum",
              style: TextStyle(
                  fontSize: screenWidth * 0.1,
                  color: Colors.white38,
                  fontFamily: "MotleyForces",
                  fontWeight: FontWeight.w800),
            ),
          )),
      Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Positioned(
              //     // align with arrow, the canon fire function
              //     bottom: screenHeight * 0.15,
              //     right: 0,
              //     child: Container(
              //         margin: EdgeInsets.fromLTRB(0, screenHeight * 0.06, 0, 0),
              //         width: screenWidth * 0.14,
              //         height: screenHeight * 0.14,
              //         child: Image(
              //             image: AssetImage("images/game/canonpic.png")))),
              Positioned(
                  // align with arrow, the canon fire function
                  bottom: screenHeight * 0.15,
                  right: 0,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, screenHeight * 0.06, 0, 0),
                      width: screenWidth * 0.14,
                      height: screenHeight * 0.14,
                      child:
                          Image(image: AssetImage("images/game/bomb_s.gif")))),

              Positioned(
                  left: screenWidth * 0.45,
                  bottom: screenHeight * 0.18,
                  // alignment: Alignment(screenWidth * 0.5, 0.3 * screenHeight),
                  child: Stack(
                    children: [
                      Container(
                          child: Transform.rotate(
                              angle: -pi / 2,
                              child: Container(
                                  width: screenWidth * 0.14,
                                  height: screenHeight * 0.1,
                                  child: const Image(
                                      image: AssetImage(
                                          "images/game/bowandarrow.png"))))),
                      Container(
                        // pending on variable injection via balloon position

                        child: Transform.rotate(
                            angle: -pi / 2,
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                // transform:
                                //     RotatedBox(quarterTurns: quarterTurns),
                                width: screenWidth * 0.14,
                                height: screenHeight * 0.1,
                                child: const Image(
                                    image: AssetImage("images/game/bow.png")))),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    // color: Colors.red,
                    child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        childAspectRatio: 2 / 1,
                        children: keyBoard(screenWidth, 1)),
                  ))
            ],
          ))
    ]);
  }
}
