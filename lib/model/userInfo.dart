import 'dart:ffi';

class UserProfiles {
  final String UUID;
  final String Name;
  final int Score;
  final int Level;
  final String IPaddress;
  final String Email;
  final List DeviceInfo;

  UserProfiles({
    required this.UUID,
    required this.Name,
    required this.Score,
    required this.Email,
    required this.Level,
    required this.IPaddress,
    required this.DeviceInfo,
  });
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
}
/*Example
UserProfile userProfile = UserProfile{
  UUID:"123123",
  Name:"Spear",
  Score:123,
  Email:"spear@gf.com"
};
*/
