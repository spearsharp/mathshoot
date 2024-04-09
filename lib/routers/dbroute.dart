class DBmysql {
  final String DBhost;
  final int DBport;
  final String DBname;
  final String DBuser;
  final String DBpassword;
  DBmysql({
    required this.DBhost,
    required this.DBport,
    required this.DBname,
    required this.DBuser,
    required this.DBpassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'DBhost': DBhost,
      'DBport': DBport,
      'DBname': DBname,
      'DBuser': DBuser,
      'DBpassword': DBpassword,
    };
  }
}
