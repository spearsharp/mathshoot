import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final Map arguments;
  const Setting({super.key, required this.arguments});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("arguments"));
  }
}
