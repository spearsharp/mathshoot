import 'dart:ffi';

class UserProfiles {
  final String UUID;
  final String Name;
  final Int Score;
  final String Email;

  UserProfiles(
      {required this.UUID,
      required this.Name,
      required this.Score,
      required this.Email});
}

class UserSettings {
  final String UUID;
  final String Name;
  final Bool TouchSound;
  final Bool GameMusic;
  final Bool BGM;
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