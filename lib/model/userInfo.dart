import 'dart:convert';

import 'package:arithg/model/userinfo.dart';

UserProfiles userProfilesFromJson(String str) =>
    UserProfiles.fromJson(json.decode(str));

String userProfilesToJson(UserProfiles data) => json.encode(data);

class UserProfiles {
  UserProfiles({
    // all mandatory inputed
    required this.UUID,
    required this.Name,
    required this.Score,
    required this.Email,
    required this.Account,
    required this.Level,
    required this.IPaddress,
    required this.DeviceInfo,
    required this.AccBalance,
    required this.BombBalance,
    required this.PaymentInfo,
    required this.PersonalLog,
  });

  String UUID;
  String Name;
  int Score;
  String Email;
  String IPaddress;
  List Account; // Account info/google,facebook , twitter login
  int Level;
  int AccBalance;
  int BombBalance;
  List DeviceInfo;
  List PaymentInfo;
  List PersonalLog;

  factory UserProfiles.fromJson(Map<String, dynamic> json) {
    return UserProfiles(
        UUID: json["UUID"],
        Name: json['Name'],
        Score: json['Score'],
        Email: json['Email'],
        Account: json['Account'],
        Level: json['Level'],
        IPaddress: json['IPaddress'],
        DeviceInfo: json['DeviceInfo'],
        AccBalance: json['AccBalance'],
        BombBalance: json['BombBalance'],
        PaymentInfo: json['PaymentInfo'],
        PersonalLog: json['PersonalLog']);
  }

  Map<String, dynamic> toJson() {
    return {
      'UUID': UUID,
      'Name': Name,
      'Score': Score,
      'Level': Level,
      'AccBalance': AccBalance,
      'BombBalance': BombBalance,
      'IPaddress': IPaddress,
      'Email': Email,
      'Account': Account,
      'DeviceInfo': DeviceInfo,
      'PaymentInfo': PaymentInfo,
      'PersonalLog': PersonalLog,
    };
  }
}

UserSettings userSettingFromJson(String str) =>
    UserSettings.fromJson(json.decode(str));

String userSettingToJson(UserSettings data) => jsonEncode(data);

class UserSettings {
  UserSettings({
    required this.UUID,
    required this.Name,
    required this.TouchSound,
    required this.GameMusic,
    required this.BGM,
    required this.Portrait,
  });
  String UUID;
  String Name;
  bool TouchSound;
  bool GameMusic;
  bool BGM;
  String? Portrait;

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
        UUID: json['UUID'],
        Name: json['Name'],
        TouchSound: json['TouchSound'],
        GameMusic: json['GameMusic'],
        BGM: json['BGM'],
        Portrait: json['Portrait']);
  }

  Map<String, dynamic> toJson() {
    return {
      'UUID': UUID,
      'Name': Name,
      'TouchSound': TouchSound,
      'GameMusic': GameMusic,
      'BGM': BGM,
      'Portrait': Portrait,
    };
  }
}

TxnInfo txnInfoFromJson(String str) => TxnInfo.fromJson(json.decode(str));

String txnInfoToJson(TxnInfo data) => json.encode(data);

class TxnInfo {
  TxnInfo({
    required this.UUID,
    required this.Name,
    required this.TxnStatus,
    required this.TxnAmt,
    required this.AccNum,
    required this.PaymentType,
    required this.PaymentTime,
  });
  String UUID;
  String Name;
  String TxnStatus;
  double TxnAmt;
  String AccNum;
  String PaymentType;
  DateTime PaymentTime;

  factory TxnInfo.fromJson(Map<String, dynamic> json) {
    return TxnInfo(
        UUID: json['UUID'],
        Name: json['Name'],
        TxnStatus: json['TxnStatus'],
        TxnAmt: json['TxnAmt'],
        AccNum: json['AccNum'],
        PaymentType: json['PaymentType'],
        PaymentTime: json['PaymentTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'UUID': UUID,
      'Name': Name,
      'TxnStatus': TxnStatus,
      'TxnAmt': TxnAmt,
      'AccNum': AccNum,
      'PaymentType': PaymentType,
      'PaymentTime': PaymentTime,
    };
  }
}
/*Example
UserProfile userProfile = UserProfile{
  UUID:"123123",
  Name:"Spear",
  Score:123,
  Email:"spear@gf.com"
};
*/
