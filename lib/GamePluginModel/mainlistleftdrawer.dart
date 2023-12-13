import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../services/screeenAdapter.dart';

class Mainlistleftdrawer extends StatefulWidget {
  final Map arguments;
  const Mainlistleftdrawer({super.key, required this.arguments});

  @override
  State<Mainlistleftdrawer> createState() => _MainlistleftdrawerState();
}

class _MainlistleftdrawerState extends State<Mainlistleftdrawer> {
  bool soundStatus =
      false; // pending on change to read record from local storage
  // @override
  // void initState() {
  //   super.initState();
  //   print(widget.arguments);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: ScreenAdapter.width(380),
        // height: ScreenAdapter.height(880),
        child: ListView(
      children: [
        Row(children: [
          const Row(children: [
            Text(
              "Touch Sound",
              style: TextStyle(
                  fontFamily: 'Ballony', fontSize: 30, color: Colors.black87),
            )
          ]),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  print("tap to change status");
                  setState(() {
                    soundStatus != soundStatus;
                  });
                },
                icon: soundStatus
                    ? Icon(Icons.toggle_on)
                    : Icon(Icons.toggle_off),
              ))
        ]),
      ],
    ));
  }
}
