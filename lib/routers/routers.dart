import 'dart:ffi';
import 'dart:ui';

import 'package:arithg/Game/gamelvl2.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'dart:async';
import 'dart:math';
import '../Game/gamemain.dart';
import '../Game/gamelvl1.dart';
import '../Game/mainlist.dart';
import '../Game/setting.dart';
import '../services/screeenAdapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/localStorage.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'services/arith.dart';

final Map<String, Function> routes = {
  "/": () => const GameMain(),
  "/gamelvl1": (context, {arguments}) => GameLvl1(arguments: arguments),
  "/gamelvl2": (context, {arguments}) => GameLvl2(arguments: arguments),
  // "/level3": (context, {arguments}) => GameLvl3(arguments: arguments),
  // "/level4": (context, {arguments}) => GameLvl4(arguments: arguments),
  // "/level5": (context, {arguments}) => GameLvl5(arguments: arguments),
  // "/level6": (context, {arguments}) => GameLvl6(arguments: arguments),
  // "/level7": (context, {arguments}) => GameLvl7(arguments: arguments),
  // "/level8": (context, {arguments}) => GameLvl8(arguments: arguments),
  // "/level9": (context, {arguments}) => GameLvl9(arguments: arguments),
  // "/level10": (context, {arguments}) => GameLvl10(arguments: arguments),
  // "/level11": (context, {arguments}) => GameLvl11(arguments: arguments),
  // "/level12": (context, {arguments}) => GameLvl12(arguments: arguments),
  // "/level13": (context, {arguments}) => GameLvl13(arguments: arguments),
  "/setting": (context, {arguments}) => Setting(arguments: arguments),
  "/mainlist": (context, {arguments}) => Mainlist(arguments: arguments),
};

var onGernerateRoute = (RouteSettings settings) {
  print(settings);
  print(settings.name);
  print(settings.arguments);
  final String? name = settings.name;
  final Route route;
  final Function? pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.name != null) {
      route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
    } else {
      route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    }
    return route;
  } else {
    return null;
  }
};
