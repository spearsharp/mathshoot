import 'dart:convert';
import 'package:mysql1/mysql1.dart';
import '../model/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

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
  //DBconn select check
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
}
