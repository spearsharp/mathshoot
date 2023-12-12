import 'package:arithg/services/screeenAdapter.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../Game/gamelvl1.dart';
import '../Game/gamelvl2.dart';
import '../services/iconUtil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../services/setting.dart';

class Mainlist extends StatefulWidget {
  final Map arguments;
  const Mainlist({super.key, required this.arguments});

  @override
  State<Mainlist> createState() => _MainlistState();
}

class _MainlistState extends State<Mainlist> {
  int num = 14;

  //map arguments
  // final List routepath = [
  //   ' gamelvl1',
  //   ' gamelvl2',
  // ];
  final List _arguments = [
    {
      'levelname': '1',
      'routepath': '/gamelvl1',
      'gameunlockstatus': "unlocked",
      'arguments': {'title': "title1"}
    },
    {
      'levelname': '2',
      'routepath': '/gamelvl2',
      'gameunlockstatus': "locked",
      'arguments': {'title': "title2"}
    },
  ];

  // final List levelname = [
  //   ' 1',
  //   ' 2',
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //play BGM
    var _assertAudioPlayer = AssetsAudioPlayer();
    _assertAudioPlayer.open(
      Audio("audios/mainlistBGM.wav"),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );
  }

  List<Widget> _inkwelllvltitle(_ScreenAdapter) {
    List<Widget> tmplist = [];
    for (int i = 0; i < _arguments.length; i++) {
      print(_arguments[i]['levelname']);
      print(_arguments[i]['arguments']);
      print(_arguments[i]['gameunlockstatus'] == "unlocked");
      tmplist.add(
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, _arguments[i]['routepath'],
                arguments: _arguments[i]);
          },
          child: Container(
            alignment: Alignment.topCenter,
            width: _ScreenAdapter.height * 0.1,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('images/game/yellowtitlebelt.png'))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // height: 55,
                    // width: 60,
                    children: <Widget>[
                      //pending function - onchanged() setState to update pic status
                      Image(
                        //debug pic
                        image: _arguments[i]['gameunlockstatus'] == "unclocked"
                            ? const AssetImage("images/game/dollarsignpic.png")
                            : const AssetImage("images/game/lockedbluepic.png"),
                        width: _ScreenAdapter.width * 0.07,
                        height: _ScreenAdapter.width * 0.07,
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                      )
                    ]),
                SizedBox(
                  width: _ScreenAdapter.width * 0.03,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ignore: prefer_interpolation_to_compose_strings
                      AutoSizeText(
                        "Level:" + _arguments[i]['levelname'],
                        minFontSize: 35,
                        maxFontSize: 45,
                        style: const TextStyle(
                          fontFamily: 'CreamCake',
                        ),
                      ),
                    ])
              ],
            ),
          ),
        ),
      );
    }
    // tmplist.add(
    //   Positioned(child: TextButton)
    // )
    return tmplist;
  }

  @override
  Widget build(BuildContext context) {
    final _ScreenAdapter = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: mainlistleftdrawer(),
      ),

      appBar: AppBar(
        title: Row(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: AutoSizeText(
              "Math Balloon",
              minFontSize: 25,
              maxFontSize: 30,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'Balloony', color: Colors.white70),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {
                    print("1111111111"); // pending topup function
                  },
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage('images/game/icon/goldcoin.png'),
                        width: 20,
                      ),
                      AutoSizeText('111111',
                          minFontSize: 18,
                          maxFontSize: 25,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'CreamCake', color: Colors.white70)),
                    ],
                  ))),
        ]),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          child: Stack(children: [
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/game/blackboardbkgpic.jpg"))),
          child: ListView(
            children: _inkwelllvltitle(_ScreenAdapter),
          ),
        ),
        // Positioned(
        //     top: _ScreenAdapter.height * 0.055,
        //     right: -30,
        //     child: InkWell(
        //         onTap: () {
        //           print("topup money");
        //         },
        //         child: Container(
        //           width: 100,
        //           child: const Row(
        //             children: [
        //               Expanded(
        //                   flex: 1,
        //                   child: Image(
        //                     image: AssetImage("images/game/icon/goldcoin.png"),
        //                   )),
        //               Expanded(
        //                 flex: 4,
        //                 child: Text(
        //                     "123", // pending on topup fuunction, show the balancef
        //                     style: TextStyle(
        //                         fontSize: 20,
        //                         fontFamily: 'MotleyForces',
        //                         color: Colors.blueGrey)),
        //               )
        //             ],
        //           ),
        //         ))),
      ])),
      // floatingActionButton: ElevatedButton.icon(
      //     onPressed: () {
      //       print("topup money");
      //     },
      //     icon: Icon(Icons.attach_money_outlined),
      //     label: Text("18")),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

mainlistleftdrawer() {
  return Container(
    child: Setting(
      arguments: {'title': 'title'},
    ),
    // child: const Center(
    //     child: Image(image: AssetImage("images/game/icon/goldcoin.png"))

    // IconButton(
    //     onPressed: () {},
    //     icon: const Icon(
    //       IconsPool.goldcoin,
    //       size: 100,
    //     )),
  );
}
