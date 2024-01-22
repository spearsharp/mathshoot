class UserProfiles {
  final String UUID;
  final String Name;
  final int Score;
  final int Level;
  final int AccBalance;
  final int BombBalance;
  final String IPaddress;
  final String Email;
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
      required this.Portrait});
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
/*Example
UserProfile userProfile = UserProfile{
  UUID:"123123",
  Name:"Spear",
  Score:123,
  Email:"spear@gf.com"
};
*/
