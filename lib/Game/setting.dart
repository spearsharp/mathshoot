import '../GamePluginModel/mainlistleftdrawer.dart';
import '../services/screeenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:awesome_select/awesome_select.dart';

class Setting extends StatefulWidget {
  final Map arguments;
  const Setting({super.key, required this.arguments});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Map arguments;

  @override
  void initState() {
    super.initState();
    print("widge_settings:${widget.arguments}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 40,
              fontFamily: 'PWBalloon',
              color: Colors.black87,
              fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Mainlistleftdrawer(arguments: {'title': 'title'}),
    );
  }
}
