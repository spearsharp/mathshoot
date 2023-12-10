import 'dart:ui';

import 'package:arithg/routers/routers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/utils.dart';
import '../services/screeenAdapter.dart';
import 'package:flutter/material.dart';

class GameMain extends StatefulWidget {
  const GameMain({Key? key}) : super(key: key);

  @override
  State<GameMain> createState() => _GameMainState();
}

class _GameMainState extends State<GameMain> {
  var _assetAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
    _assetAudioPlayer.open(
      Audio('audios/mainenteranceBGM.wav'),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _assetAudioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(),
      body: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/game/animatedballonbackgroumdpic.gif"),
          )),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
                // width: screenWidth * 0.6,
                alignment: Alignment.bottomCenter,
                child: ListView(
                  children: [
                    SizedBox(height: screenHeight * 0.35),
                    SizedBox(
                      height: screenHeight * 0.2,
                      child: Image(
                          image:
                              AssetImage("images/game/animatedmathsign.gif")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/gamelvl1",
                              arguments: {"title": "mainpage"});
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, screenHeight * 0.015),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("images/game/yellowtitlebelt.png"),
                            )),
                            child: const Text(
                              "Start",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 36.0,
                                color: Color.fromARGB(255, 28, 16, 1),
                                decorationStyle: TextDecorationStyle.dashed,
                                letterSpacing: 5.0,
                                decorationColor: Colors.white,
                                fontFamily: 'MagicBaloon',
                              ),
                            ))),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/gamelvl1",
                              arguments: {"title": "mainpage"});
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, screenHeight * 0.015),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("images/game/yellowtitlebelt.png"),
                            )),
                            child: const Text(
                              "Exit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 36.0,
                                color: Color.fromARGB(255, 28, 16, 1),
                                decorationStyle: TextDecorationStyle.dashed,
                                letterSpacing: 5.0,
                                decorationColor: Colors.white,
                                fontFamily: 'MagicBaloon',
                              ),
                            ))),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/gamelvl1",
                              arguments: {"title": "mainpage"});
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, screenHeight * 0.015),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("images/game/yellowtitlebelt.png"),
                            )),
                            child: const Text("Setting",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 36.0,
                                  color: Color.fromARGB(255, 28, 16, 1),
                                  decorationStyle: TextDecorationStyle.dashed,
                                  letterSpacing: 5.0,
                                  decorationColor: Colors.white,
                                  fontFamily: 'MagicBaloon',
                                ))))
                  ],
                ))
          ])),
    );
  }
}
