import 'dart:convert';
import 'dart:async';

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
import 'package:mysql1/mysql1.dart';

class GameMain extends StatefulWidget {
  const GameMain({Key? key}) : super(key: key);

  @override
  State<GameMain> createState() => _GameMainState();
}

class _GameMainState extends State<GameMain> {
  late Map _deviceinfo;
  late String _deviceinfoS;
  final _assetAudioPlayer = AssetsAudioPlayer();
  final _keyAudioPlayer = AssetsAudioPlayer();
  late UserProfiles _userProfiles;
  late UserSettings _userSettings;
  late NetworkInfo ipmacAddr;
  late bool resBTBGM, resTHBGM, resGMBGM;

  //DB connection   - ref:https://pub.dev/packages/mysql1/example
  Future _dbConn(String DBname, String sqlsen, List queryVar) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: "localhost",
      port: 3306,
      user: 'root',
      db: 'mathshoot',
      password: 'Spear19830805',
    ));
    var res = await conn.query("select * from user_gameInfo");
    for (var row in res) {
      print('Name:${row[0]},level:${row[3]},Score:${row[4]}');
    }
    ;
    await conn.close(); // close connection
    return res;
  }

  Future _getDevic() async {
    final deviceinfoplugin = DeviceInfoPlugin();
    final deviceinfo = await deviceinfoplugin.deviceInfo;
    final deviceinfomap = deviceinfo.data;
    _deviceinfo = deviceinfomap;
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

  Future _setLocalStorage(key, val) async {
    var res = await localStorage.setData(
        key, val); // fix the localstorage set get del data module
    print("res:::");
    print(res is JsonCodec);
    // Timer.periodic(const Duration(milliseconds: 4000), (t) {
    //   print("setdata-done");
    //   t.cancel();
    // });
  }

  Future _getLocalStorage(key) async {
    var res = await localStorage
        .getData(key); // fix the localstorage set get del data module
    return res;
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

  Future _deleteStorage(key) async {
    var res = await localStorage.removeData(key);
    print("res:::$res");
  }

  Future _uuidUNameGen<List>() async {
    late List t_list;
    String t_uuid = await Tools.uuid();
    String t_uName = await Tools.uName(10);
    _setLocalStorage("UUID", t_uuid);
    _setLocalStorage("Name", t_uName);
    t_list = [t_uuid, t_uName] as List;
    print("t_list_ninner:${t_list.toString()}");
    return t_list.toString();
  }

  //V1 no backend server node,payment to stripe backend management , dart connnect to mysql directly

  @override
  void initState() {
    super.initState();
    // _getDeviceInfo();
    // _getIpMacAddr();
    print("system broughtup , testing");
    // _uuidUNameGen().then((value) => print(value as String));
    // _deleteStorage("UUID").then((value) => print(value));

    ///User Loing check and localinfo patch
    _getLocalStorage("UUID").then((resdata) async {
      print("resdata:$resdata");
      if (resdata == null) {
        print("localstorage-UUID getting fail");
        // check based on new device or not
        uuid = Tools.uuid();
        uName = Tools.uName(10);
        _userProfiles = UserProfiles(
            UUID: uuid,
            Name: uName,
            Score: 0,
            Email: "0@0.com",
            Level: 1,
            AccBalance: 0,
            BombBalance: 0,
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
              "0"
            ]);
        String tempMap = _userProfiles.toString();
        print("_userProfiles:$tempMap");
        //initial Personal settings
        _userSettings = UserSettings(
          UUID: uuid,
          Name: uName,
          TouchSound: true,
          GameMusic: true,
          BGM: true,
          Portrait: "",
        );
        var retSetPS = localStorage.setData("UUID", _userSettings.UUID);
        print("userProfiles:$_userProfiles,,,userSettings:$_userSettings");
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
        //get all personal info from local and server  ---patch data from server

        String _uuid = localStorage.getData("UUID");
        print("_uuid:$_uuid");

        uuid = _userProfiles.UUID;
        uName = _userProfiles.Name;
        print("_userSettings.BGM:${_userSettings.BGM}");
        _userSettings.BGM
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
                          print("_assetAudioPlayer:$tttt");
                          print("_userSettings:$_userSettings");
                          print("_userProfiles:$_userProfiles");
                          //press key sound
                          _userSettings.BGM
                              ? _keyAudioPlayer.open(
                                  Audio('audios/pressmobilekeyBGM.wav'),
                                  autoStart: true,
                                  loopMode: LoopMode.none)
                              : null;
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
