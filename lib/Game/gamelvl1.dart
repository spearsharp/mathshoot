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
import '../model/userInfo.dart';
import 'package:audioplayers/audioplayers.dart';
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
  late DateTime gameStartTime;
  bool levelkeep = true,
      gamestart = false,
      countdown = false,
      gamepause = false;

  final List arrowLocation = [0.0, 0.0];
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
    super.initState();
    _assetAudioPlay.open(
      Audio("audios/level1_BGM.mp3"),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );

//check globalkey initialized

    //arrowposition globalkey

    print(widget.arguments);

//initialize patch data from backend server
    accbalance = 111;
    bombbalance = 11;
    // accbalance =
    //     widget.arguments["accbalance"]; // fetch accbalance frome mainpage

    void gamekickoff() {} // remove if no necessary
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
                            gamepause = true;
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
    _assetAudioPlay.stop();
    _keyAudioPlayer.stop();
    _inputController.close();
    _scoreController.close();
    super.dispose();
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
            title: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: StreamBuilder(
                      stream: _scoreController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (score >= 0) {
                            score += snapshot.data as int;
                            if (score < 0) {
                              score = 0;
                              print("Game Over");
                              setState(() {
                                gamepause = true;
                              });
                              // stop game and popup failure mask, and show play again/exit
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
                                AutoSizeText("score： $score",
                                    minFontSize: 15,
                                    maxFontSize: 30,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'PWBalloon',
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28)),
                              ],
                            ));
                      }),
                ),
                Expanded(
                    child: Expanded(
                        flex: 1,
                        // full screen with topup money
                        child: InkWell(
                            onTap: () {
                              print("topup money");
                            },
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Image(
                                        image: AssetImage(
                                            "images/game/icon/goldcoinpic.png"),
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: AutoSizeText(' 123',
                                        minFontSize: 18,
                                        maxFontSize: 25,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'MotleyForces',
                                            color: Colors.yellowAccent)),
                                  )
                                ],
                              ),
                            ))))
              ],
            )),
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
                    print("ballonIndex_init:$index");
                    print("screenHeightinit:$screenHeight");
                    print("screenWidthinit:$screenWidth");
                    gameStartTime = DateTime.now();
                    return Game(
                      gamearguments: gamearguements,
                      gameStartTime: gameStartTime,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      inputController: _inputController,
                      scoreController: _scoreController,
                      arrowController: _arrowController,
                      gamepause: gamepause,
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
                    ? // keypad and arrowshooting
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: KeyPad(
                                //use another container to wrap it ensure the arrowbow and bomb in right position with keypad
                                inputController: _inputController,
                                screenWidth: screenWidth,
                                accbalance: accbalance,
                                T: false,
                                bombbalance: bombbalance,
                                screenHeight: screenHeight,
                              )),
                          Positioned(
                              left: screenWidth * 0.45,
                              bottom: screenHeight * 0.17,
                              child: Stack(children: [
                                Container(
                                    child: Transform.rotate(
                                        angle: -pi / 2,
                                        child: Container(
                                            width: screenWidth * 0.14,
                                            height: screenHeight * 0.1,
                                            child: const Image(
                                                image: AssetImage(
                                                    "images/game/bowandarrow.png"))))),
                              ]))
                        ]))
                    : gamestart
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: KeyPad(
                                      //use another container to wrap it ensure the arrowbow and bomb in right position with keypad
                                      inputController: _inputController,
                                      screenWidth: screenWidth,
                                      accbalance: accbalance,
                                      T: false,
                                      bombbalance: bombbalance,
                                      screenHeight: screenHeight,
                                    )),
                                Positioned(
                                    left: screenWidth * 0.45,
                                    bottom: screenHeight * 0.17,
                                    child: Stack(children: [
                                      Container(
                                          child: Transform.rotate(
                                              angle: -pi / 2,
                                              child: Container(
                                                  width: screenWidth * 0.14,
                                                  height: screenHeight * 0.1,
                                                  child: const Image(
                                                      image: AssetImage(
                                                          "images/game/bowandarrow.png"))))),
                                    ]))
                              ],
                            ))
                        : const Text(""),
                //tap to kickoff game, level1
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
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.inputController,
    required this.scoreController,
    required this.gameStartTime,
    required this.gamepause,
    required this.gamearguments,
    required this.arrowController,

    // required this.levelController,
  }) : super(key: key);
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  //call arith module
  final GlobalKey _Gamekey = GlobalKey();
  late Map gamearguements, bowarrowStatus;
  late double x;
  late int a, b, c, d, e, f, g, netscore, levelevent, ballonIndex;
  late Color color;
  late bool t,
      l,
      gamepause; // if bombing , need to stop the almost close to finished balloon
  late int shootDuration, accbalance;
  late DateTime gameStartTime;
  late double screenWidth, screenHeight;
  int durationTime = Random().nextInt(5000) + 5800;
  String m = '()';
  String n = '/';
  late AnimationController _animationController;
  late StreamController<List> arrowController;
  late List arrowLocation,
      bombing; // pending on change to realtime patch balloon position

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

  //score update upon _scoreController.stream -> rebuild streambuilder in realtime
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
  ListView _UpdatePic(t, d, e, List arrowLocation, List bombing) {
    if (t) {
// print("爆炸图");
//arrow shoot , fadetransition, slidetransition
      // insert arrowshooting function
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

/*
core function : This section include all core features and functional flag here.
1.balloon controller
2.arrowshooting controller
3.detect num of bomb controller
4.game start
5.game pause
6.game resume
7.game levelup/game failed
8.score recorder/awarding
9.core arith calling
10topup money
*/

  @override
  void initState() {
    //1.balloon controller
    super.initState();
    screenHeight = widget.screenHeight;
    screenWidth = widget.screenWidth;

    //game param patch
    a = Random().nextInt(99);
    b = Random().nextInt(99);
    c = Random().nextInt(9);
    final Map gamearguments = {"gamepause": false};
    gamepause = widget.gamepause;
    bombing = [
      {"bombingNum": 1}
    ];
    bowarrowStatus = {
      "bowReady": true, // pendingon arrowbow rotation
      "arrowshooted": false,
      "bowEmpty": false,
    };
    arrowController = widget.arrowController;
    //

    late int speed;
    netscore = 0;
    gameStartTime = widget.gameStartTime;

    // game started
    reset(widget.screenWidth); //first round to play
    arrowLocation = [x, 0.0];
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
        var renderBox =
            _Gamekey.currentContext!.findRenderObject() as RenderBox;
        final Offset bollonPos = renderBox.localToGlobal(Offset.zero);
        print(
            "Animation-Positioned-component's position is (${bollonPos.dx}, ${bollonPos.dy})");
//2.arrowshooting controller
        arrowLocation = [
          bollonPos.dx,
          bollonPos.dy
        ]; //get realtime balloon location

        print("arrowController:$arrowController");
        bowarrowStatus = {
          "bowReady": true,
          "arrowshooted": true,
          "bowEmpty": false
        };

        t = true;
        score(t, widget.gameStartTime);
        // level(l);
        // trigger arrow shooting
        // var result = _arrowhooting(
        //     t, widget.screenHeight, widget.screenWidth, arrowlocation);
        // print("result:$result");

        await Future.delayed(Duration(milliseconds: 300));
        _UpdatePic(t, d, e, arrowLocation, bombing);
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
      print("gamepause:$gamepause");
      if (gamepause == true) {
        _animationController.stop();
      }
      //get inputController data,and monitorring
    });
    //game complete
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Positioned(
                key: _Gamekey,
                top: Tween(
                        begin: widget.screenHeight * 0.6,
                        end: -widget.screenHeight * 0.3)
                    .animate(_animationController)
                    .value,
                left: x,
                child: Container(
                    // decoration: ,
                    color: Colors.red.withOpacity(0),
                    width: widget.screenWidth * 0.25,
                    height: widget.screenHeight * 0.3,
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: _UpdatePic(t, d, e, arrowLocation, bombing)));
          }),
    ]);
  }
}

//arrow shooting and animation
// class arrowshoot extends StatefulWidget {
//   final List arrowLocation;
//   final Map bowarrowStatus;
//   final double screenWidth, screenHeight;
//   final StreamController<List> arrowController;
//   const arrowshoot({
//     super.key,
//     required this.arrowLocation,
//     required this.screenWidth,
//     required this.screenHeight,
//     required this.arrowController,
//     required this.bowarrowStatus,
//   });

//   @override
//   State<arrowshoot> createState() => _arrowshootState();
// }

// class _arrowshootState extends State<arrowshoot>
//     with SingleTickerProviderStateMixin {
//   late double screenWidth,
//       screenHeight,
//       initscreenHeight,
//       initscreenWidth,
//       endscreenHeight,
//       endscreenWidth;
//   late AnimationController _arrowShootingAnimationController,
//       _arrowRotationAnimationController;
//   late List arrowLocation;
//   late StreamController arrowController;
//   late bool bowReady, arrowshooted, bowEmpty;
//   late Map bowarrowStatus;
//   late double endx, endy;

//   @override
//   void initState() {
//     super.initState();
//     //data transmit
//     screenWidth = widget.screenWidth;
//     screenHeight = widget.screenHeight;
//     initscreenHeight = widget.screenHeight * 0.18;
//     initscreenWidth = widget.screenWidth * 0.45;
//     endscreenHeight = widget.screenHeight * 0.18;
//     endscreenWidth = widget.screenWidth * 0.45;
//     arrowController = widget.arrowController;
//     bowarrowStatus = widget.bowarrowStatus;
//     bowReady = bowarrowStatus["bowReady"];
//     arrowshooted = bowarrowStatus["arrowshooted"];
//     bowEmpty = bowarrowStatus["bowEmpty"];
//     endx = widget.arrowLocation[0];
//     endy = widget.arrowLocation[1];

// // animated arrow rotation
//     // _arrowRotationAnimationController = AnimationController(
//     //     vsync: this,
//     //     duration: const Duration(milliseconds: 500),
//     //     lowerBound: positiveRotated,
//     //     upperBound: nagetiveRotated);

//     print("arrowlocation:$arrowLocation");
//     _arrowShootingAnimationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1000));
//     _arrowShootingAnimationController.forward();

//     _arrowShootingAnimationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         print("arrow shooting status complete");
//       }

//       if (status == AnimationStatus.forward) {
//         print("arrow shooting status shooted");
//       }

//       if (status == AnimationStatus.dismissed) {
//         print("arrow shooting status dismissed");
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _arrowShootingAnimationController.dispose();
//     _arrowRotationAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("endx:$endx,,endy:$endy");
//     return Center(
//         child: SlideTransition(
//             position: _arrowShootingAnimationController
//                 .drive(CurveTween(curve: Curves.elasticInOut))
//                 .drive(Tween(begin: Offset(0.0, -10), end: Offset(1, 10))),
//             // begin: Offset(initscreenWidth / 100, initscreenHeight / 10),
//             // end: Offset(endx / 100, endy / 10))),
//             child: Container(
//                 width: screenWidth * 0.02,
//                 height: screenHeight * 0.02,
//                 child: Text(
//                   "测试",
//                   style: TextStyle(fontSize: 30),
//                 ))));
//     // child: const Image(image: AssetImage("images/game/arrow.png"))));)
//   }
// }
//keypad monitorring

class KeyPad extends StatefulWidget {
  final StreamController<int> inputController;
  final double screenWidth, screenHeight;
  final bool T;
  final int accbalance, bombbalance;
  const KeyPad(
      {super.key,
      required this.inputController,
      required this.screenWidth,
      required this.accbalance,
      required this.T,
      required this.bombbalance,
      required this.screenHeight});

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
          left: 0.3 * widget.screenWidth,
          right: 0.3 * widget.screenWidth,
          top: 0.5 * widget.screenHeight,
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
                        fontSize: widget.screenWidth * 0.1,
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
                      bottom: widget.screenHeight * 0.15,
                      right: 0,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0, widget.screenHeight * 0.06, 0, 0),
                          width: widget.screenWidth * 0.17,
                          height: widget.screenHeight * 0.17,
                          child: InkWell(
                              onTap: () {
                                print(
                                    "bomb break the balloon,detect the bomb number"); // 1 bomb for 1 bolloon  and trigger bolloon break animation - target the balloon on answer, write the returned answer into a list and for bomb break
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "$bombbalance",
                                    style: TextStyle(
                                        fontFamily: "MotleyForces",
                                        fontSize: widget.screenWidth * 0.06,
                                        color: Colors.grey[800]),
                                  ),
                                  Image(
                                      height: widget.screenWidth * 0.11,
                                      width: widget.screenWidth * 0.11,
                                      image:
                                          AssetImage("images/game/bomb_s.gif"))
                                ],
                              )))),
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
                            widget.screenWidth, 1)), // change to streambuilder
                  ))
            ],
          ))
    ]);
  }
}
