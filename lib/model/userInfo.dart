class UserProfiles {
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

  Map<String, dynamic> toMap() {
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

class UserSettings {
  final String UUID;
  final String Name;
  final bool TouchSound;
  final bool GameMusic;
  final bool BGM;
  final String Portrait;

  UserSettings(
      {required this.UUID,
      required this.Name,
      required this.TouchSound,
      required this.GameMusic,
      required this.BGM,
      required this.Portrait,
      required});
  Map<String, dynamic> toMap() {
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

class TxnInfo {
  final String UUID;
  final String Name;
  final String TxnStatus;
  final double TxnAmt;
  final String AccNum;
  final String PaymentType;
  final DateTime PaymentTime;

  TxnInfo({
    required this.UUID,
    required this.Name,
    required this.TxnStatus,
    required this.TxnAmt,
    required this.AccNum,
    required this.PaymentType,
    required this.PaymentTime,
  });

  Map<String, dynamic> toMap() {
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
