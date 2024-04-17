import 'dart:convert';
import 'dart:async';
import 'dart:ffi';

import 'package:arithg/routers/dbroute.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/utils.dart';
import 'package:mysql1/mysql1.dart';
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

  late String _deviceinfoS, uuid, uName; // uName not initiialized
  final _assetAudioPlayer = AssetsAudioPlayer();
  final _keyAudioPlayer = AssetsAudioPlayer();
  late UserProfiles
      userProfiles; // move to main.dart and independent module for verify
  late UserSettings
      userSettings; // move to main.dart and independent module for verify
  late NetworkInfo ipmacAddr;
  late bool resBTBGM, resTHBGM, resGMBGM;
//  -- pendingpayment setting wihtout account/ID,payment page , payment history page - pending - https://www.youtube.com/watch?v=tpILK64NM6M&list=PL3n34TOL-kqIeGsSDa-o7tK-Z6h2ubyf-&index=20&t=192s&pp=gAQBiAQB

//get deviceInfo
  Future _getDevic() async {
    final deviceinfoplugin = DeviceInfoPlugin();
    final deviceinfo = await deviceinfoplugin.deviceInfo;
    final deviceinfomap = deviceinfo.data;
    Map<String, dynamic> _deviceinfo = deviceinfomap;
    _deviceinfoS = jsonEncode(_deviceinfo);
    print("_deviceinfo:$_deviceinfo");
    print("_deviceinfoS:$_deviceinfoS");
    print("succ_get_deviceINfo");
  }

  Future _patchPersonalInfo(uuid) async {
    //sec check
    var response = await Dio().post("https://www.goldmanfuks.com/api/httpget",
        queryParameters: {"UUID": uuid});
    print(response.data is Map);
    print(response.data["userProfiles"]);
  }

  Future _dispatchPersonalInfo(uuid) async {
    //sec check
    var response = await Dio().post("https://www.goldmanfuks.com/api/httppost",
        queryParameters: {"UUID": uuid});
    print(response.data is Map);
    print(response.data["userProfiles"]);
  }

  Future _getIpMacAddr() async {
    ipmacAddr = await NetworkService().getNetworkInfo();
    print("ipmacAddr:$ipmacAddr");
    print(ipmacAddr is Map);
    print("ipmacAddr.ipAddress: ${ipmacAddr.ipAddress}");
  }

  Future _getLocalStorage(key) async {
    var res = await localStorage
        .getData(key); // fix the localstorage set get del data module
    return res;
  }

  Future _setLocalStorage(key, val) async {
    var res = await localStorage.setData(key, val);
  }

  Future _buttonBGM() async {
    final bool resBTBGM = true;
    // var resBTBGM = await _getLocalStorage("BGM");  // pending on localStorage patch
    print("resBTBGM:$resBTBGM");
    switch (resBTBGM) {
      case true:
        return _keyAudioPlayer.open(Audio('audios/pressmobilekeyBGM.wav'),
            autoStart: true, loopMode: LoopMode.none);
      case false:
        return null;
      case null:
        print("resBTBGM:$resBTBGM");
        return _keyAudioPlayer.open(Audio('audios/pressmobilekeyBGM.wav'),
            autoStart: true, loopMode: LoopMode.none);
      default:
        return _keyAudioPlayer.open(Audio('audios/pressmobilekeyBGM.wav'),
            autoStart: true, loopMode: LoopMode.none);
    }
    // ignore: unrelated_type_equality_checks
  }

  Future _deleteStorage(key, action) async {
    var res = await localStorage.removeData(key);
    print("res:::delete - $action - $res");
  }

  Future _uuidUNameGen<List>() async {
    late List t_list;
    String t_uuid = await Tools.uuid();
    String t_uName = await Tools.uName(10);
    t_list = [t_uuid, t_uName] as List;
    print("t_list_ninner:${t_list.toString()}");
    return t_list.toString();
  }

  //V1 no backend server node,payment to stripe backend management , dart connnect to mysql directly

  @override
  void initState() {
    super.initState();
    // _getDeviceInfo() and infra deviceinfo  -- pending
    // _getIpMacAddr() -- pending

    print("system broughtup , testing");
    // _uuidUNameGen().then((value) => print(value as String));
    // _deleteStorage("UUID").then((value) => print(value));

    ///User Loing check and localinfo patch
    // _deleteStorage("UUID", "delete");
    _getLocalStorage("UUID").then((resdata) async {
      print("resdata:$resdata");
      if (resdata == null) {
        print("localstorage-UUID getting fail");
        // check based on new device or not
        uuid = await Tools.uuid();
        uName = await Tools.uName(10);
        print("uuid:$uuid --- uName:$uName");
        //create user id , use set/get to input
        userProfiles = UserProfiles(
            // initial userProfiles
            UUID: uuid,
            Name: uName,
            Score: 0,
            Email: "0@0.com",
            Level: 1,
            AccBalance: 0, // initial accBal
            BombBalance: 0, // initial bombBal
            IPaddress: "0.0.0.0",
            Account: [
              uuid
            ],
            DeviceInfo: [
              {"macAddress": "1231231"}
            ],
            PaymentInfo: [
              "0"
            ],
            PersonalLog: [
              "initial"
            ]);
        // String tempMap = _userProfiles.toString();
        print("userProfiles:$userProfiles");
        userSettings = UserSettings(
          // initial userSettings
          UUID: uuid,
          Name: uName,
          TouchSound: true,
          GameMusic: true,
          BGM: true,
          Portrait: "0",
        );

        //create Personal payment acc , set/get input
        var retSetPS = localStorage.setData(
            "UUID", userSettings.UUID); // save pesonal data
        var resSetUP = localStorage.setData(
            'userProfiles', jsonEncode(userProfiles.toJson()));
        var retSetUS = localStorage.setData(
            'userSettings', jsonEncode(userSettings.toJson()));
        print("userProfiles:$userProfiles,,,userSettings:$userSettings");

        //1st time login to play BGM
        _assetAudioPlayer.open(
          Audio('audios/mainenteranceBGM.wav'),
          autoStart: true,
          showNotification: true,
          loopMode: LoopMode.single,
        );
        // var sevDataSavResp = _dispatchPersonalInfo(uuid); // data saving
        //post personal info to server
      } else {
        print("localstorage-UUID getting succ");
        print('resdata:${resdata}}');
        //get all personal info from local and server  ---patch data from server
        var tmpUP = localStorage.getData("userProfiles");
        print("tmpUP:$tmpUP");
        userProfiles = UserProfiles.fromJson(tmpUP);
        userSettings =
            UserSettings.fromJson(localStorage.getData("userSettings"));
        print(userProfiles is String);
        print(userProfiles is JsonCodec);
        //change to set get
        String _uuid = userProfiles.UUID;
        String _uName = userProfiles.Name;

        print(
            "_uuid:$_uuid & _uName:$uName & userSettings.BGM:${userSettings.BGM}");

        userSettings.BGM
            ? _assetAudioPlayer.open(
                Audio('audios/mainenteranceBGM.wav'),
                autoStart: true,
                showNotification: true,
                loopMode: LoopMode.single,
              )
            : null;
        // UserProfiles userProfilesSev = _patchPersonalInfo(uuid);
        //health check on data synchronized
      }
    });

//check and get personl info from local Storage

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
                          // print("_assetAudioPlayer:$tttt");
                          // print("_userSettings:$_userSettings");
                          // print("_userProfiles:$_userProfiles");
                          //press key sound
                          userSettings.BGM
                              ? _keyAudioPlayer.open(
                                  Audio('audios/pressmobilekeyBGM.wav'),
                                  autoStart: true,
                                  loopMode: LoopMode.none)
                              : null;
                          Navigator.pushNamed(context, "/mainlist", arguments: {
                            "title": "mainlist",
                            "userSettings": userSettings,
                            "userProfiles": userProfiles,
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
                          userSettings.BGM
                              ? _keyAudioPlayer.open(
                                  Audio('audios/pressmobilekeyBGM.wav'),
                                  autoStart: true,
                                  loopMode: LoopMode.none)
                              : null;
                          // _buttonBGM();
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
                          userSettings.BGM
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
                    InkWell(
                        onTap: () {
                          _deleteStorage("userProfiles", "deleteUserProfiles");
                          _deleteStorage("userSettings", "deleteUserSettings");
                        },
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                              "adv - click clean cache"), // pending advertisment
                        ))
                  ],
                ))
          ])),
    );
  }
}
