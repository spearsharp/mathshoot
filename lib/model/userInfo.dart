import 'dart:ffi';

class UserProfiles {
  final String UUID;
  final String Name;
  final Int Score;
  final String Email;

  UserProfile(
      {required this.UUID,
      required this.Name,
      required this.Score,
      required this.Email});
}
