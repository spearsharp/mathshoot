import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class localStorage {
  static setData(String? key, dynamic val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key!, json.encode(val));
  }

  static getData(String? key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key!);
    return json.decode(data!);
  }

  static removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
