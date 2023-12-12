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
  @override
  Widget build(BuildContext context) {
    var _soundStatus;
    return Center(
        child: ListView(
      children: [
        Row(children: [
          Expanded(
              flex: 1,
              child: Text(
                "Touch Sound",
                style: TextStyle(fontFamily: 'Ballony', fontSize: 30),
              )),
          Expanded(
              flex: 1,
              child: FlutterSwitch(
                value: _soundStatus,
                onToggle: (_soundStatus) {
                  setState(() {
                    _soundStatus = _soundStatus;
                  });
                },
              ))
        ]),
      ],
    ));
  }
}
