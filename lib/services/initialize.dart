import 'dart:convert';
import '../services/localStorage.dart';
import '../services/shareUtils.dart';
import 'package:mysql1/mysql1.dart';
import '../model/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../model/shareContent.dart';
import '../services/result.dart';
import '../routers/dbroute.dart';

late var conn;
late Map _deviceinfo;
late String _deviceinfoS;
late bool initialsucc;

//db connection
Future _dbConn(DBmysql) async {
  DBmysql('DBhost') ?? "localhost";
  DBmysql('DBname') ?? "bytepuz";
  DBmysql('DBport') ?? 3306;
  DBmysql('DBuser') ?? "root";
  DBmysql('DBpassword') ?? "Spear19830805";
  try {
    conn = await MySqlConnection.connect(ConnectionSettings(
      host: DBmysql('DBhost'),
      port: DBmysql('DBport'),
      user: DBmysql('DBuser'),
      db: DBmysql('DBname'),
      password: DBmysql('DBpassword'),
    ));
  } catch (e) {
    initialsucc = false;
    print("DB connection failed");
  } finally {
    print("MySQL conn succ");
    return conn;
  }
  //conn done
}

//device info collection
Future _getDevic() async {
  final deviceinfoplugin = DeviceInfoPlugin();
  try {
    final deviceinfo = await deviceinfoplugin.deviceInfo;
    final deviceinfomap = deviceinfo.data;
    _deviceinfo = deviceinfomap;
    _deviceinfoS = jsonEncode(_deviceinfo);
  } catch (e) {
    initialsucc = false;
    return initialsucc;
  } finally {
    print("_deviceinfo:$_deviceinfo");
    print("_deviceinfoS:$_deviceinfoS");
    print("succ_get_deviceINfo");
    print("c");
    return _deviceinfoS; // return string
    // return deviceinfomap; // return map
  }
}

class Initialize {
  //DBconn select check  -- pending using later
  // Future _selAll(DBname, sqlsen, queryVar) async {
  //   DBmysql(
  //       DBhost: "localhost",
  //       DBport: 3306,
  //       DBname: "bytepuz",
  //       DBuser: "root",
  //       DBpassword: "Spear19830805");
  //   _dbConn(DBmysql);
  //   var res = await conn.query("select * from user_info");
  //   print("res:$res");
  //   for (var row in res) {
  //     print('Name:${row[0]},level:${row[3]},Score:${row[4]}');
  //   }
  //   ;
  //   //conn release
  //   await conn.close(); // close connection
  // }

  //initilized global value,initial data checking

  //DBconnection

  static UserProfiles userProfiles = UserProfiles();
  static UserSettings userSettings =
      UserSettings(TouchSound: true, GameMusic: true, BGM: true);
  static TxnInfo txnInfo = TxnInfo();
  //get userProfiles  -- pending
  static getUserProfiles() async {
    var _userProfiles = await ShareUtils.getString(ShareContent.userProfile);
    if (_userProfiles != null && _userProfiles != '') {
      var jsonData = json.decode(_userProfiles);
      UserProfiles data = UserProfiles.fromJson(json.decode(jsonData));
      return DataRes(data, true);
    } else {
      return DataRes(null, false);
    }
  }

  //get userSettings -- pending
  static getUserSettings() async {
    var _userSettings = await ShareUtils.getString(ShareContent.userProfile);
    if (_userSettings != null && _userSettings != '') {
      var jsonData = json.decode(_userSettings);
      UserSettings data = UserSettings.fromJson(jsonData);
      return DataRes(data, true);
    } else {
      return DataRes(null, false);
    }
  }

  //get txninfo -- pending
  static getUserTxnInfo() async {
    var _userTxnInfo = await ShareUtils.getString(ShareContent.txnInfo);
    if (_userTxnInfo != null && _userTxnInfo != '') {
      var jsonData = json.decode(_userTxnInfo);
      TxnInfo data = TxnInfo.fromJson(jsonData);
      return DataRes(data, true);
    } else {
      return DataRes(null, false);
    }
  }

// set User Profiles
  static setUserProfiles(userProfiles) {
    ShareUtils.setString(
        ShareContent.userProfile, json.encode(userProfiles?.toJson));
  }

//set User Settings
  static setUserSettings(userSettings) {
    ShareUtils.setString(
        ShareContent.userSettings, json.encode(userSettings?.toJson));
  }

  //set User Settings
  static setTxnInfo(userSettings) {
    ShareUtils.setString(ShareContent.txnInfo, json.encode(txnInfo?.toJson));
  }

  //delete caches -- pending
  static clearAll() {
    //delete user profiles
    ShareUtils.remove(ShareContent.userProfile);
//delete user settings
    ShareUtils.remove(ShareContent.userSettings);
//delete user Txninfo
    ShareUtils.remove(ShareContent.txnInfo);
  }
}
