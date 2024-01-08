import 'dart:ffi';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final Map arguments; // arguments transfer balance
  const GameLvl1({super.key, required this.arguments});

  @override
  State<GameLvl1> createState() => _GameLvl1State();
}

class _GameLvl1State extends State<GameLvl1> {
  late Map gamearguements;
  late bool levelup;
  late int accbalance,
      bombbalance; //accbalance transfered from mainlist and bombalance patch from local storage and database
  // ignore: unused_field
  late List<GlobalKey>
      _globalKey; // for positioned location dispatch for arrowshooting using.
  late DateTime gameStartTime;
  bool levelkeep = true,
      gamestart = false,
      countdown = false,
      gamepause = false;
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

    // accbalance == null ? 111 : widget.arguments["accbalance"];
    //    bombbalance == null ? 11 : widget.arguments["bombbalance"];
    accbalance = 111;
    bombbalance = 11;
    // accbalance =
    //     widget.arguments["accbalance"]; // fetch accbalance frome mainpage
    void gamekickoff() {}
  }

  void keypresssound() {
    _keyAudioPlayer.open(Audio('audios/pressmobilekeyBGM.wav'),
        autoStart: true, loopMode: LoopMode.none);
  }

  void audioStop() {
    _assetAudioPlay.stop();
  }

  void backtoMainList() async {
    setState(() {
      gamepause = true;
    });
    var result = await showDialog(
        barrierDismissible: true,
        barrierLabel: "Good",
        context: context,
        builder: (contect) {
          return AlertDialog(
            titleTextStyle: TextStyle(fontFamily: "Balloony"),
            title: const Text("Exit the game?"),
            content: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage("images/game/3balloonpopupmsg.png")))),
            actions: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "images/game/animatedbuttonBGP.gif"))),
                      child: TextButton(
                        onPressed: () {
                          print("resume the game");
                          setState(() {
                            gamepause = false;
                          });
                        },
                        child: Text(
                          "Resume",
                          style: TextStyle(
                              fontFamily: "Motlyforce",
                              color: Colors.amber[900]),
                        ),
                      )),
                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "images/game/animatedbuttonBGP.gif"))),
                      child: TextButton(
                        onPressed: () {
                          print("exit to mainlist");
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Exit",
                          style: TextStyle(
                              fontFamily: "Motlyforce",
                              color: Colors.yellow[900]),
                        ),
                      ))
                ],
              ),
            ],
          );
        });
    print("pause_game_result:$result");
  }

  @override
  void dispose() {
    super.dispose();
    _assetAudioPlay.stop();
    _keyAudioPlayer.stop();
  }

  Future<bool> _loadingcountdownpic() {
    // loading countdown animated pic
    return Future(() => Future.delayed(const Duration(seconds: 6)));
  }

  void countdownpicload() async {
    // set gamestart to true and kickoff the game
    setState(() {
      countdown = true;
    });
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      gamestart = true;
      countdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width;
    final Map gamearguements = {"gamepause": false, "title": "level1"};
    print("screenHeight: $screenHeight");
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white70),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            onPressed: () {
              backtoMainList();
            },
          ),
          title: StreamBuilder(
              stream: _scoreController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (score >= 0) {
                    score += snapshot.data as int;
                    if (score < 0) {
                      score = 0;
                      print("Game Over"); // stop game and popup failure mask
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
                  // change the number to generate the numbers of balloon
                  print("durationTime:: $durationTime");
                  // generate numbers of baloon
                  if (gamestart == true && countdown == false) {
                    gameStartTime = DateTime.now();
                    return Game(
                      gamearguments: gamearguements,
                      gameStartTime: gameStartTime,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      inputController: _inputController,
                      scoreController: _scoreController,
                      arrowController: _arrowController, gamepause: gamepause,
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
                    : gamestart // 6balloon foreground pic loading
                        ? const Text("")
                        : countdown
                            ? Text("")
                            : Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                              height: screenHeight * 0.4,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    alignment:
                                                        Alignment.topCenter,
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
                                        onTap: () {
                                          countdownpicload();
                                        },
                                        child: const Image(
                                            width: 280,
                                            height: 80,
                                            image: AssetImage(
                                              "images/game/animatedplay.gif",
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                countdown
                    ? KeyPad(
                        inputController: _inputController,
                        screenWidth: screenWidth,
                        accbalance: accbalance,
                        T: false,
                        bombbalance: bombbalance,
                      )
                    : gamestart
                        ? KeyPad(
                            inputController: _inputController,
                            screenWidth: screenWidth,
                            accbalance: accbalance,
                            T: false,
                            bombbalance: bombbalance,
                          )
                        : const Text(""),
                //tap to kickoff game, level1

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
  final Map gamearguments;
  final double screenHeight;
  final double screenWidth;
  final bool gamepause;
  final StreamController<int> inputController;
  final StreamController<int> scoreController;
  final StreamController<List> arrowController;
  final DateTime gameStartTime;
  // final StreamController<int> levelController;
  const Game({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inputController,
    required this.scoreController,
    required this.arrowController,
    required this.gameStartTime,
    required this.gamepause,
    required this.gamearguments,
    // required this.levelController,
  });
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  //call arith module
  late Map gamearguements;
  late double x;
  late int a, b, c, d, e, f, g, netscore, levelevent;
  late Color color;
  late bool t, l, gamepause;
  late int shootDuration, accbalance;
  late DateTime gameStartTime;
  int durationTime = Random().nextInt(5000) + 5800;
  String m = '()';
  String n = '/';
  late AnimationController _animationController;
  List arrowlocation = [
    11.1,
    12.2
  ]; // pending on change to realtime patch balloon position

//game level started

//game restart
  reset(screenWidth) {
    // reset to generate new arithquote
    // var arithRes = arithCalcSentence(){};   // insert arith
    t = false;
    d = Random().nextInt(5) + 1;
    e = Random().nextInt(5);
    x = Random().nextDouble() * screenWidth * 0.7;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  // levelup(level) { // level up animated pic
  //   int speed = (5000 + 5000 / 2 * level) as int;
  //   return speed;
  // }

  // levelfailed(level) {   // levelfailed animated pic and next pic
  //   int speed = (5000 + 5000 / 2 * level) as int;
  //   return speed;
  // }

//level up and awearded

  //score update
  score(t, gameStartTime) {
    if (t) {
      widget.scoreController.add(3);
      netscore = netscore + 3;
      if (netscore > 10) {
        l = true;
        shootDuration = DateTime.now().difference(gameStartTime).inMilliseconds;
        print("shootDuration:$shootDuration ");
        netscore = (netscore + (netscore ~/ shootDuration) * 2)
            as int; // shooting duration time shooter and higher scored
        print("shootDuration:$shootDuration ");
        //save score to localstorage
        // netscore = 0;
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

  // ignore: non_constant_identifier_names
  ListView _UpdatePic(t, d, e) {
    // insert arrowshooting function
    if (t) {
// print("爆炸图");
//arrow shoot , fadetransition, slidetransition
      t = false;
      return ListView(children: [
        Container(
            color: Colors.transparent,
            child: const Image(
              image: AssetImage("images/game/goldcyclebomb.gif"),
              fit: BoxFit.contain,
            )),
      ]);
    } else {
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
    }
  }

  ListView _arrowhooting(t, screenHeight, screenWidth, arrowlocation) {
    return ListView(children: [
      AnimatedPositioned(
          top: t ? screenHeight * 0.6 : -screenHeight * 0.3,
          left: t ? screenWidth * 0.6 : -screenWidth * 0.3,
          duration: Duration(microseconds: 300),
          child: const Image(
            image: AssetImage("images/game/smogbomb.gif"),
            fit: BoxFit.contain,
          )),
    ]);
  }

  @override
  void initState() {
    a = Random().nextInt(99);
    b = Random().nextInt(99);
    c = Random().nextInt(9);
    final Map gamearguments = {"gamepause": false};
    gamepause = widget.gamepause;

    late int speed;
    netscore = 0;
    super.initState();
    gameStartTime = widget.gameStartTime;

    // game started
    reset(widget.screenWidth); //first round to play

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationTime));
    _animationController.forward();

    widget.inputController.stream.listen((event) async {
      //pending update input display and flag to route.
      int total = d + e;
      print("d:: $d");
      print("e:: $e");
      print("event:: $event");

      if (total == event) {
        // _animationArrowController = AnimationController(
        //     vsync: this, duration: Duration(milliseconds: 300));
        // _animationController
        //     .forward(); // two methods to shoot balloo , 1st - shooting includinto game section, 2nd - setup an independent section for animation arrowshooting.but how to align with those two parts.. TBD
        // // score correct
        var location = _animationController.status;
        print("location:$location");
        var arrowshootResult = arrowshoot(
          screenWidth: ScreenAdapter.getScreenWidth(),
          screenHeight: ScreenAdapter.getScreenHeight(),
          arrowlocation: [],
        );
        t = true;
        arrowlocation = [1.1, 1, 2]; //get realtime balloon location
        score(t, widget.gameStartTime);
        // level(l);
        // trigger arrow shooting
        var result = _arrowhooting(
            t, widget.screenHeight, widget.screenWidth, arrowlocation);
        print("result:$result");

        await Future.delayed(Duration(milliseconds: 200));
        _UpdatePic(t, d, e);
        reset(widget.screenWidth);
        _animationController.forward(from: 0.0);
      }
    });
    _animationController.addStatusListener((status) {
      //listening KeyPad press

      if (status == AnimationStatus.completed) {
        t = false;
        score(t, widget.gameStartTime);
        reset(widget.screenWidth);
        _animationController.forward(from: 0.0);
      }

      //click setting button to stop the game and waiting for next action
      if (gamepause) {
        _animationController.stop();
      } else {
        //click setting button to stop the game and waiting for next action
        _animationController.forward();
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
              key: GlobalKey,
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
  const arrowshoot(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.arrowlocation});

  @override
  State<arrowshoot> createState() => _arrowshootState();
}

class _arrowshootState extends State<arrowshoot>
    with SingleTickerProviderStateMixin {
  late double initscreenHeight, initscreenWidth;
  late AnimationController _arrowcontroller;
  late List arrowlocation;

  @override
  void initState() {
    super.initState();
    var arrowlocation = widget.arrowlocation;
    print("arrowlocation:$arrowlocation");
    final AnimationController _arrowcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _arrowcontroller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _arrowcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double initscreenHeight = widget.screenHeight * 0.18;
    final double initscreenWidth = widget.screenWidth * 0.45;
    final double endscreenHeight = widget.arrowlocation[0];
    final double endscreenWidth = widget.arrowlocation[1];
    return AnimatedBuilder(
      animation: _arrowcontroller,
      builder: (context, child) {
        return Positioned(
            top: Tween(begin: initscreenHeight, end: endscreenHeight)
                .animate(_arrowcontroller)
                .value,
            left: Tween(begin: initscreenWidth, end: endscreenWidth)
                .animate(_arrowcontroller)
                .value,
            child: Container(
              transform: Matrix4.translationValues(
                  initscreenHeight, initscreenWidth, 0),
              width: widget.screenWidth * 0.14,
              height: widget.screenHeight * 0.1,
              child: Transform.rotate(
                  angle: -pi / 2,
                  child: const Image(
                      image: AssetImage(
                          "images/game/arrow.png"))), // angle is changing along with animation
            ));
      },
    );
  }
}
//keypad monitorring

class KeyPad extends StatefulWidget {
  final StreamController<int> inputController;
  final double screenWidth;
  final bool T;
  final int accbalance, bombbalance;
  const KeyPad(
      {super.key,
      required this.inputController,
      required this.screenWidth,
      required this.accbalance,
      required this.T,
      required this.bombbalance});

  @override
  State<KeyPad> createState() => _KeyPadState();
}

//keypad function , pending on substract independently
class _KeyPadState extends State<KeyPad> with SingleTickerProviderStateMixin {
  String displayPressNum = "";
  late String inputNum;
  late StreamController<int> inputController;
  late bool T = false;
  late int accbalance, bombbalance;
  bool sign = false, correctanswer = false;
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
                    if (displayPressNum == "") {
                      displayPressNum = "-";
                    } else {
                      if (displayPressNum.substring(0, 1) == "-") {
                        displayPressNum = displayPressNum.substring(
                            1, displayPressNum.length);
                        print("displayPressNum:$displayPressNum");
                      } else {
                        displayPressNum = "-$displayPressNum";
                        print("displayPressNum:$displayPressNum");
                      }
                    }
                    print("displayPressNum:$displayPressNum");
                    //pending on checking answer ,transit tmplist into judge  and set T= true

                    if (correctanswer == true) {
                      displayPressNum = "";
                      sign = true;
                      print("displayPressNum:$displayPressNum");
                    }
                  }
                case 11:
                  {
                    // displayPressNum = displayPressNum.substring(
                    //     0, displayPressNum.length - 1);
                    displayPressNum = "";
                    print("displayPressNum:$displayPressNum");
                    //pending on checking answer ,transit tmplist into judge , and set T= true
                    if (correctanswer == true) {
                      displayPressNum = "";
                      sign = true;
                      print("displayPressNum:$displayPressNum");
                    }
                  }
                default:
                  {
                    displayPressNum = displayPressNum + keyvalue.toString();
                    correctanswer = false;
                    sign = false;
                    //pending on checking answer ,transit tmplist into judge  and set T= true
                  }
              }
              //check answers correction ,get return
              if (correctanswer == true) {
                displayPressNum = "";
                sign = true;
                print("displayPressNum:$displayPressNum");
              }
            } else {
              presscount = 0;
              displayPressNum = "";
            }
            inputNum = displayPressNum;
            inputController.add(keyvalue);
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
    inputController = widget.inputController;
    accbalance = widget.accbalance;
    bombbalance = widget.bombbalance;
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
            child: StreamBuilder(
                stream: inputController.stream,
                builder: (context, snapshot) {
                  return Text(
                    "$displayPressNum",
                    style: TextStyle(
                        fontSize: screenWidth * 0.1,
                        color: Colors.white38,
                        fontFamily: "MotleyForces",
                        fontWeight: FontWeight.w800),
                  );
                }),
          )),
      Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            fit: StackFit.expand,
            children: [
              accbalance == 0 // debug
                  ? const Text("")
                  : Positioned(
                      // align with arrow, the canon fire function
                      bottom: screenHeight * 0.15,
                      right: 0,
                      child: Container(
                          margin:
                              EdgeInsets.fromLTRB(0, screenHeight * 0.06, 0, 0),
                          width: screenWidth * 0.17,
                          height: screenHeight * 0.14,
                          child: InkWell(
                              onTap: () {
                                print(
                                    "detect the bomb number"); // 1 bomb for 1 bolloon  and trigger bolloon break animation - target the balloon on answer, write the returned answer into a list and for bomb break
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "$bombbalance",
                                    style: TextStyle(
                                        fontFamily: "MotleyForces",
                                        fontSize: screenWidth * 0.06,
                                        color: Colors.grey[800]),
                                  ),
                                  Image(
                                      height: screenWidth * 0.11,
                                      width: screenWidth * 0.11,
                                      image:
                                          AssetImage("images/game/bomb_s.gif"))
                                ],
                              )))),
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
                      Container(
                        // pending on variable injection via balloon position
                        child: T
                            ? Transform.rotate(
                                angle: -pi / 2,
                                child: AnimatedContainer(
                                    duration: Duration(
                                        milliseconds:
                                            300), // pending on add animation
                                    // transform:
                                    //     RotatedBox(quarterTurns: quarterTurns),
                                    width: screenWidth * 0.14,
                                    height: screenHeight * 0.1,
                                    child: const Image(
                                        image: AssetImage(
                                            "images/game/arrow.png"))))
                            : Transform.rotate(
                                angle: -pi / 2, // for rotate arrow using
                                child: AnimatedContainer(
                                    duration: Duration(
                                        milliseconds:
                                            300), // pending on add animation
                                    // transform:
                                    //     RotatedBox(quarterTurns: quarterTurns),
                                    width: screenWidth * 0.14,
                                    height: screenHeight * 0.1,
                                    child: const Image(
                                        image: AssetImage(
                                            "images/game/arrow.png")))),
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
                        children: keyBoard(
                            screenWidth, 1)), // change to streambuilder
                  ))
            ],
          ))
    ]);
  }
}
