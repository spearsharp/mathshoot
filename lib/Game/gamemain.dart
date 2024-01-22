import 'dart:convert';
import 'dart:async';

import 'package:arithg/services/ipmacAddr.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/utils.dart';
import '../services/screeenAdapter.dart';
import '../routers/routers.dart';
import '../Game/gamelvl1.dart';
import '../Game/gamelvl2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/localStorage.dart';
import '../services/util.dart';
import '../services/ipmacAddr.dart';
import '../model/userInfo.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class GameMain extends StatefulWidget {
  const GameMain({Key? key}) : super(key: key);

  @override
  State<GameMain> createState() => _GameMainState();
}

class _GameMainState extends State<GameMain> {
  late Map _deviceinfo;
  late String uuid, uName, _deviceinfoS;
  final _assetAudioPlayer = AssetsAudioPlayer();
  final _keyAudioPlayer = AssetsAudioPlayer();
  late UserProfiles _userProfiles;
  late UserSettings _userSettings;
  late NetworkInfo ipmacAddr;

  _getDeviceInfo() async {
    final deviceinfoplugin = DeviceInfoPlugin();
    final deviceinfo = await deviceinfoplugin.deviceInfo;
    final deviceinfomap = deviceinfo.toMap();
    _deviceinfo = deviceinfomap;
    _deviceinfoS = jsonEncode(_deviceinfo);
    print("_deviceinfo:$_deviceinfo");
    print("_deviceinfoS:$_deviceinfoS");
  }

  _patchPersonalInfo(uuid) async {
    //sec check
    var response = await Dio().get("https://www.goldmanfuks.com/api/httpget",
        queryParameters: {"UUID": uuid});
    print(response.data is Map);
    print(response.data["userProfiles"]);
  }

  _dispatchPersonalInfo(uuid) async {
    //sec check
    var response = await Dio().get("https://www.goldmanfuks.com/api/httpget",
        queryParameters: {"UUID": uuid});
    print(response.data is Map);
    print(response.data["userProfiles"]);
  }

  _getIpMacAddr() async {
    ipmacAddr = await NetworkService().getNetworkInfo();
  }

  @override
  void initState() {
    // super.initState();
    _getDeviceInfo();
    _getIpMacAddr();
//check and get personl info from local Storage
    if (localStorage.getData("UUID") == "") {
      // check based on new device or not
      uuid = Tools.uuid();
      uName = Tools.uName(10);
      _userProfiles = UserProfiles(
          UUID: uuid,
          Name: uName,
          Score: 0,
          Email: "",
          Account: [],
          Level: 1,
          IPaddress: "",
          DeviceInfo: [],
          AccBalance: 0,
          BombBalance: 0,
          PaymentInfo: [],
          PersonalLog: []);
      //initial Personal settings
      _userSettings = UserSettings(
        UUID: Tools.uuid(),
        Name: Tools.uName(10),
        TouchSound: true,
        GameMusic: true,
        BGM: true,
        Portrait: "",
      );
      var retSet = localStorage.setData("_userSettings", _userSettings);
      print("_userProfiles:$_userProfiles,,,_userSettings:$_userSettings");
      var sevDataSavResp = _dispatchPersonalInfo(uuid); // data saving
      //post personal info to server
    } else {
      //get all personal info from local and server  ---patch data from server

      _userSettings = localStorage.getData("_userSettings");
      _userProfiles = localStorage.getData("_userProfiles");

      uuid = _userProfiles.UUID;
      uName = _userProfiles.Name;
      UserProfiles userProfilesSev = _patchPersonalInfo(uuid);
      //health check on data synchronized
    }

    _userSettings.BGM
        ? _assetAudioPlayer.open(
            Audio('audios/mainenteranceBGM.wav'),
            autoStart: true,
            showNotification: true,
            loopMode: LoopMode.single,
          )
        : null;
    //get devicesData get local data,if null,new user and gennerate all fields
  }

  @override
  void dispose() {
    super.dispose();
    _assetAudioPlayer.stop();
    _keyAudioPlayer.stop();
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
                    SizedBox(height: screenHeight * 0.40),
                    SizedBox(
                      height: screenHeight * 0.2,
                      child: const Image(
                          image:
                              AssetImage("images/game/animatedmathsign.gif")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          _assetAudioPlayer.stop();
                          var tttt = _assetAudioPlayer.playerState;
                          print("_assetAudioPlayer:$tttt");
                          //press key sound
                          _userSettings.BGM
                              ? _keyAudioPlayer.open(
                                  Audio('audios/pressmobilekeyBGM.wav'),
                                  autoStart: true,
                                  loopMode: LoopMode.none)
                              : null;
                          // rounte to level1
                          Navigator.pushNamed(context, "/mainlist", arguments: {
                            "title": "mainlist",
                            "userSettings": _userSettings,
                            "userProfiles": _userProfiles,
                          });
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
                                color: Color.fromARGB(255, 92, 51, 1),
                                decorationStyle: TextDecorationStyle.dashed,
                                letterSpacing: 5.0,
                                fontFamily: 'Balloony',
                              ),
                            ))),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    InkWell(
                        onTap: () {
                          _assetAudioPlayer.stop;
                          _userSettings.BGM
                              ? _keyAudioPlayer.open(
                                  Audio('audios/pressmobilekeyBGM.wav'),
                                  autoStart: true,
                                  loopMode: LoopMode.none)
                              : null;
                          //route to exit
                          Navigator.pushNamed(context, "/guide",
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
                              "Guide",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 36.0,
                                color: Color.fromARGB(255, 92, 51, 1),
                                decorationStyle: TextDecorationStyle.dashed,
                                letterSpacing: 5.0,
                                fontFamily: 'Balloony',
                              ),
                            ))),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    InkWell(
                        onTap: () {
                          _assetAudioPlayer.stop;
                          _assetAudioPlayer.dispose();
                          _userSettings.BGM
                              ? _keyAudioPlayer.open(
                                  Audio('audios/pressmobilekeyBGM.wav'),
                                  autoStart: true,
                                  loopMode: LoopMode.none)
                              : null;
                          //route to setting page
                          Navigator.pushNamed(context, "/setting",
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
                                  color: Color.fromARGB(255, 92, 51, 1),
                                  decorationStyle: TextDecorationStyle.dashed,
                                  letterSpacing: 5.0,
                                  fontFamily: 'Balloony',
                                )))),
                    const Positioned(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("adv"), // pending advertisment
                    ))
                  ],
                ))
          ])),
    );
  }
}
