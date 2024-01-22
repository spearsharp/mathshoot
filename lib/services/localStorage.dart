import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class localStorage {
  static setData(String? key, dynamic? val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key!, val!);
  }

  static getData(String? key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? data = prefs.getInt(key!);
    return data;
  }

  static removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
