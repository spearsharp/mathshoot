import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class localStorage {
  //get userProfiles  -- pending
  //get userProfiles -- pending
  //get userDeviceinfo -- pending
  //get txninfo -- pending
  //delete caches -- pending

  static setData(String? key, val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key!, json.encode(val));
    return true;
  }

  static getData(String? key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key!);
    if (data != null) {
      return json.decode(data);
    } else {
      return data;
    }
  }

  static removeData(String? key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key!);
  }
}
