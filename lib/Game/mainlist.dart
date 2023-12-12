import 'package:arithg/services/screeenAdapter.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import '../Game/gamelvl1.dart';
import '../Game/gamelvl2.dart';

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

  List<Widget> _inkwelllvltitle() {
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
            height: 60,
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
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ignore: prefer_interpolation_to_compose_strings
                      Text("Level:" + _arguments[i]['levelname'],
                          // Text("Level:1",
                          style: TextStyle(
                            fontFamily: 'CreamCake',
                            fontSize: 35,
                          ),
                          textAlign: TextAlign.start),
                    ])
              ],
            ),
          ),
        ),
      );
    }
    return tmplist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: Drawer(
          child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.money_off_rounded),
      )),
      drawer: Drawer(
        child: mainlistleftdrawer(),
      ),
      appBar: AppBar(
        title: const Text("Math Balloon"),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/game/blackboardbkgpic.jpg"))),
        child: ListView(
          children: _inkwelllvltitle(),
        ),
      ),
    );
  }
}

mainlistleftdrawer() {
  return Container(
    child: Center(
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete_sweep_rounded,
            size: 80,
          )),
    ),
  );
}
