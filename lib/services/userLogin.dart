import 'dart:convert';

import 'package:dio/dio.dart';

/* login status check */
class Userlogin {
  final String UUID;
  final String Name;
  final int Score;
  final String Email;
  final int Level;
  final int AccBalance;
  final int BombBalance;
  final String IPaddress;
  final List Account; // Account info/google,facebook , twitter login
  final List DeviceInfo;
  final List PaymentInfo;
  final List PersonalLog;

  Userlogin(
    this.UUID,
    this.Name,
    this.Score,
    this.Email,
    this.Level,
    this.AccBalance,
    this.BombBalance,
    this.IPaddress,
    this.Account,
    this.DeviceInfo,
    this.PaymentInfo,
    this.PersonalLog,
  );

  Future _userlogin(UUID) async {
    var response = await Dio().post("https://www.goldmanfuks.com/api/httpget",
        queryParameters: {"UUID": UUID});
    return response;
  }
}
