import 'package:arithg/GamePluginModel/mainlistleftdrawer.dart';
import 'package:arithg/services/screeenAdapter.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../Game/gamelvl1.dart';
import '../Game/gamelvl2.dart';
import '../Game/setting.dart';
import '../Game/profile.dart';
import '../services/iconUtil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Mainlist extends StatefulWidget {
  final Map arguments;
  const Mainlist({super.key, required this.arguments});

  @override
  State<Mainlist> createState() => _MainlistState();
}

class _MainlistState extends State<Mainlist> {
  int num = 14;

  final _assetAudioPlayer = AssetsAudioPlayer();
  final _keyAudioPlayer = AssetsAudioPlayer();

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

  @override
  void initState() {
    // TODO: implement initState
    //play BGM
    _assetAudioPlayer.open(
      Audio("audios/mainlistBGM.wav"),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );
    super.initState();
  }

  void keypresssound() {
    _keyAudioPlayer.open(Audio('audios/pressmobilekeyBGM.wav'),
        autoStart: true, loopMode: LoopMode.none);
  }

  @override
  void dispose() {
    super.dispose();
    _assetAudioPlayer.stop();
    _keyAudioPlayer.stop();
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
            _assetAudioPlayer.stop;
            keypresssound();
            Navigator.pushNamed(context, _arguments[i]['routepath'],
                arguments: _arguments[i]);
          },
          child: Container(
            alignment: Alignment.topCenter,
            width: _ScreenAdapter.width * 0.7,
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
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                    flex: 1,
                    child: UserAccountsDrawerHeader(
                      accountName: Text("Spear Yao"), //pending on Players Name
                      accountEmail: Text(
                          "spear.yao@goldmanfuks.com"), // Pending on Players contack info
                      // ],
                      currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              AssetImage('images/game/portrait/man2.png')),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "images/game/agrorithbkgpic2.jpg"))),
                    ))
              ],
            ),
            InkWell(
              onTap: () {
                keypresssound();
                print(
                    "route to Players record page"); // pending on route to Records page
              },
              child: const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.people),
                ),
                title: Text(
                  "Top Players",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'MotleyForces',
                      color: Colors.white70),
                ),
              ),
            ),
            const Divider(),
            InkWell(
                onTap: () {
                  keypresssound();
                  Navigator.pushNamed(context, "/profile",
                      arguments: {"title": "mainlist"});
                  print("route to Profile page"); // pending on route to Profile
                },
                child: const ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.portrait),
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'MotleyForces',
                        color: Colors.white70),
                  ),
                )),
            Divider(),
            InkWell(
              onTap: () {
                keypresssound();
                Navigator.pushNamed(context, '/setting',
                    arguments: {"title": "mainlist"});
                print(
                    "rout to setting page"); // pending on route too setting page
              },
              child: const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.settings),
                ),
                title: Text(
                  "Setting",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'MotleyForces',
                      color: Colors.white70),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                keypresssound();
                print("rout to Topup page");
              },
              child: const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.attach_money),
                ),
                title: Text(
                  "Topup",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'MotleyForces',
                      color: Colors.white70),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                keypresssound();
                Navigator.pushNamed(context, '/guide',
                    arguments: {"title": "mainlist"});
                print("rout to Topup page");
              },
              child: const ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.gamepad_sharp),
                ),
                title: Text(
                  "guide",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'MotleyForces',
                      color: Colors.white70),
                ),
              ),
            )
          ],
        ),
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
                    keypresssound();
                    print("top up function"); // pending to topup function
                  },
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage('images/game/icon/goldcoinpic.png'),
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
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Text("adv"), // pending advertisment
            ))
      ])),
    );
  }
}

class _mainlistleftdrawer extends StatefulWidget {
  final Map arguments;
  const _mainlistleftdrawer({super.key, required this.arguments});

  @override
  State<_mainlistleftdrawer> createState() => __mainlistleftdrawerState();
}

class __mainlistleftdrawerState extends State<_mainlistleftdrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: Mainlistleftdrawer(
        arguments: {'title': 'title'},
      ),
    );
  }
}
