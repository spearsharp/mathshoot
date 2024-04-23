import 'dart:convert';
import '../routers/dbroute.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mysql1/mysql1.dart';

late var conn;
//DB MySQL connection   - ref:https://pub.dev/packages/mysql1/example , sync with local info. except the Top players list

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
    print("DB connection failed");
  } finally {
    print("MySQL conn succ");
    return conn;
  }
  //conn done
}

// ignore: camel_case_types
class DBstore {
  //DBconn check
  _selAll(DBname, sqlsen, queryVar) async {
    DBmysql(
        DBhost: "localhost",
        DBport: 3306,
        DBname: "bytepuz",
        DBuser: "root",
        DBpassword: "Spear19830805");
    _dbConn(DBmysql);
    var res = await conn.query("select * from user_info");
    print("res:$res");
    for (var row in res) {
      print('Name:${row[0]},level:${row[3]},Score:${row[4]}');
    }
    //conn release
    await conn
        .close(); // close connection, check procedure where to close conn --pending
    return res;
  }

//pending - reorg set
  static saveData(String? key, val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key!, json.encode(val));
    return true;
  }

//pending -  reorg get
  static selectData(String? key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key!);
    if (data != null) {
      return json.decode(data);
    } else {
      return data;
    }
  }

  static updateData(String? key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var resDel = prefs.remove(key!);
    print("resDel::: $resDel");
    return resDel;
  }
}
