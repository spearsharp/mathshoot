import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class localStorage {
  static setData(String? key, dynamic val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
