// import 'dart:ffi';
// import 'dart:ui';

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:get/utils.dart';
// import 'dart:async';
// import 'dart:math';
// import 'Game/gamelvl1.dart';
// import 'services/screeenAdapter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'services/localStorage.dart';
// import 'package:audioplayers/audioplayers.dart';
// // import 'services/arith.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Flatter Game",
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late bool levelup;
//   bool levelkeep = true;
//   int currentlevel = 0;
//   // final player = AudioPlayer();
//   AudioPlayer audioPlayer = AudioPlayer();
//   AudioCache audiocache = AudioCache(); //and this

//   final StreamController<int> _inputController =
//       StreamController.broadcast(); //multiple listener
//   final StreamController<int> _scoreController = StreamController.broadcast();
//   final StreamController<int> _levelController = StreamController.broadcast();
//   var _assetAudioPlay = AssetsAudioPlayer.newPlayer();
//   int score = 0;
//   int level = 1;
//   int baloonAmt = 1;
//   int durationTime = Random().nextInt(5000) + 5800;

//   @override
//   void initState() {
//     super.initState();

//     _assetAudioPlay.open(
//       // local audio play , assetsaudioplayer
//       Audio("audios/9346.wav"),
//       autoStart: true,
//       showNotification: true,
//       loopMode: LoopMode.single,
//     );
//   }

//   void audioStop() {
//     _assetAudioPlay.stop();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData queryData = MediaQuery.of(context);
//     double screenHeight = queryData.size.height;
//     double screenWidth = queryData.size.width;
//     print("screenHeight: $screenHeight");
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           centerTitle: true,
//           shadowColor: Colors.transparent,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: StreamBuilder(
//               stream: _scoreController.stream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   if (score >= 0) {
//                     score += snapshot.data as int;
//                     if (score > 20) {
//                       print("level up");
//                       audioStop();
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return GameLvl1(score: score);
//                       }));
//                     }
//                     if (score < 0) {
//                       score = 0;
//                       print("Game Over");
//                     }
//                   } else {
//                     score = 0;
//                   }
//                   // localStorage.setData("levelName", level);
//                 }
//                 if (snapshot.hasError) {
//                   return Text("Error: ${snapshot.error}");
//                 }
//                 return Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Wrap(
//                       alignment: WrapAlignment.spaceBetween,
//                       children: [
//                         Text("您的得分： $score"),
//                         Text(
//                           "关卡： $level",
//                         )
//                       ],
//                     ));
//               }),
//         ),
//         body: Container(
//             height: screenHeight,
//             width: screenWidth,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage("images/game/bgpic1.jpeg"))),
//             child: Stack(
//               children: [
//                 // clevel = localStorage.getData("levelName"),
//                 // Text("Children level: $clevel"),
//                 ...List.generate(10, (index) {
//                   print("durationTime:: $durationTime");
//                   // generate numbers of baloon
//                   return Game(
//                       screenHeight: screenHeight,
//                       screenWidth: screenWidth,
//                       inputController: _inputController,
//                       scoreController: _scoreController,
//                       levelController: _levelController);
//                 }),
//                 // localStorage.removeData("levelName"),
//                 KeyPad(inputController: _inputController)
//               ],
//             )));
//   }
// }

// //Arithmatic game section
// class Game extends StatefulWidget {
//   final double screenHeight;
//   final double screenWidth;
//   final StreamController<int> inputController;
//   final StreamController<int> scoreController;
//   final StreamController<int> levelController;
//   const Game(
//       {super.key,
//       required this.screenHeight,
//       required this.screenWidth,
//       required this.inputController,
//       required this.scoreController,
//       required this.levelController});
//   @override
//   State<Game> createState() => _GameState();
// }

// class _GameState extends State<Game> with SingleTickerProviderStateMixin {
//   late double x;
//   late int a, b, c, d, e, f, g, netscore, levelevent;
//   late Color color;
//   late bool t, l;
//   int durationTime = Random().nextInt(5000) + 5800;
//   String m = '()';
//   String n = '/';
//   late AnimationController _animationController;

// //game restart
//   reset(screenWidth) {
//     // var arithRes = arithCalcSentence(){};   // insert arith
//     t = true;
//     d = Random().nextInt(5) + 1;
//     e = Random().nextInt(5);
//     x = Random().nextDouble() * screenWidth * 0.7;
//     color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
//   }

//   // levelup(level) {
//   //   int speed = (5000 + 5000 / 2 * level) as int;
//   //   return speed;
//   // }

//   //score update
//   score(t) {
//     if (t) {
//       widget.scoreController.add(-1);
//       netscore = netscore - 1;
//       if (netscore < 0) {
//         l = false;
//         netscore = 0;
//       }
//     } else {
//       widget.scoreController.add(3);
//       netscore = netscore + 3;
//       if (netscore > 10) {
//         l = true;
//         netscore = 0;
//       }
//     }
//   }

//   level(bool l) {
//     // print("levelevent : ${levelevent}");
//     if (l == true) {
//       widget.levelController.add(1);
//     } else if (l == false && levelevent > 1) {
//       widget.levelController.add(-1);
//     }
//   }

//   // ignore: non_constant_identifier_names
//   ListView _UpdatePic(t, d, e) {
//     if (t) {
//       // print("气球图");
//       return ListView(children: [
//         Container(
//             color: Colors.red.withOpacity(0),
//             child: Image(image: AssetImage("images/game/1baloon.png"))),
//         Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Text("$d+$e=?", style: const TextStyle(fontSize: 18))),
//       ]);
//     } else {
//       // print("爆炸图");
//       t = true;
//       return ListView(children: [
//         Container(
//             color: Colors.red.withOpacity(0),
//             child: const Image(
//               image: AssetImage("images/game/smogbomb.gif"),
//               fit: BoxFit.contain,
//             )),
//       ]);
//     }
//   }

// //level up and awearded

//   @override
//   void initState() {
//     a = Random().nextInt(99);
//     b = Random().nextInt(99);
//     c = Random().nextInt(9);
//     late int speed;
//     netscore = 0;
//     super.initState();

//     reset(widget.screenWidth); //first round to play
//     // TODO: implement initState
//     _animationController = AnimationController(
//         vsync: this, duration: Duration(milliseconds: durationTime));
//     _animationController.forward();
//     widget.inputController.stream.listen((event) {
//       int total = d + e;
//       print("d:: $d");
//       print("e:: $e");
//       print("event:: $event");

//       if (total == event) {
//         t = false;
//         score(t);
//         level(l);
//         setState(() {
//           _UpdatePic(t, d, e);
//           reset(widget.screenWidth);
//           _animationController.forward(from: 0.0);
//         });
//       }
//     });
//     _animationController.addStatusListener((status) {
//       //listening KeyPad press

//       if (status == AnimationStatus.completed) {
//         t = false;
//         score(t);
//         reset(widget.screenWidth);
//         _animationController.forward(from: 0.0);
//       }
//       //get inputController data,and monitorring
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData queryData = MediaQuery.of(context);
//     double screenHeight = queryData.size.height;
//     double screenWidth = queryData.size.width;
//     return AnimatedBuilder(
//         animation: _animationController,
//         builder: (context, child) {
//           return Positioned(
//               top: Tween(begin: screenHeight * 0.6, end: -screenHeight * 0.3)
//                   .animate(_animationController)
//                   .value,
//               left: x,
//               child: Container(
//                   // decoration: ,
//                   color: Colors.red.withOpacity(0),
//                   width: screenWidth * 0.25,
//                   height: screenHeight * 0.3,
//                   padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
//                   child: _UpdatePic(t, d, e)));
//         });
//   }
// }

// //keypad monitorring
// class KeyPad extends StatelessWidget {
//   final StreamController<int> inputController;
//   const KeyPad({super.key, required this.inputController});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//           // color: Colors.red,
//           child: GridView.count(
//         shrinkWrap: true,
//         crossAxisCount: 5,
//         childAspectRatio: 5 / 4,
//         children: List.generate(10, (index) {
//           return TextButton(
//               style: ButtonStyle(
//                   shape:
//                       MaterialStateProperty.all(const RoundedRectangleBorder()),
//                   backgroundColor:
//                       MaterialStateProperty.all(Colors.primaries[index][300]),
//                   foregroundColor: MaterialStateProperty.all(Colors.black45)),
//               onPressed: () {
//                 inputController.add(index);
//               },
//               child: Text("$index",
//                   style: Theme.of(context).textTheme.headlineMedium));
//         }),
//       )),
//     );
//   }
// }
