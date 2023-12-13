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
  bool touchsoundStatus =
      false; // pending on change to read record from local storage
  bool bkgsoundStatus =
      false; // pending on change to read record from local storage
  // @override
  // void initState() {
  //   super.initState();
  //   print(widget.arguments);
  // }

  @override
  Widget build(BuildContext context) {
    var _screenAdapter = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/game/agrorithbkgpic2.jpg"))),
        child: ListView(
          children: [
            Container(
              height: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Touch Sound",
                      style: TextStyle(
                          fontFamily: 'Ballony',
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600),
                    ),
                    Align(
                        alignment: const Alignment(0, 111),
                        child: FlutterSwitch(
                          width: 75.0,
                          height: 35.0,
                          valueFontSize: 15.0,
                          toggleSize: 45.0,
                          value: soundStatus,
                          borderRadius: 30.0,
                          padding: 4.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              soundStatus = val;
                              print("Touch sound"); // on/off action
                            });
                          },
                        )),
                  ]),
            ),
            Container(
              height: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Touch Sound",
                      style: TextStyle(
                          fontFamily: 'Ballony',
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600),
                    ),
                    Align(
                        alignment: const Alignment(0, 111),
                        child: FlutterSwitch(
                          width: 75.0,
                          height: 35.0,
                          valueFontSize: 15.0,
                          toggleSize: 45.0,
                          value: touchsoundStatus,
                          borderRadius: 30.0,
                          padding: 4.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              touchsoundStatus = val;
                              print("Game sound"); // on/off action
                            });
                          },
                        )),
                  ]),
            ),
            Container(
              height: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Touch Sound",
                      style: TextStyle(
                          fontFamily: 'Ballony',
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600),
                    ),
                    Align(
                        alignment: const Alignment(0, 111),
                        child: FlutterSwitch(
                          width: 75.0,
                          height: 35.0,
                          valueFontSize: 15.0,
                          toggleSize: 45.0,
                          value: bkgsoundStatus,
                          borderRadius: 30.0,
                          padding: 4.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              bkgsoundStatus = val;
                              print("background sound"); // on/off action
                            });
                          },
                        )),
                  ]),
            ),
            const Divider(
              thickness: 0.4,
              color: Colors.black87,
              height: 2,
            ),
            Container(
              height: _screenAdapter.height * 0.1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          print("route to personal records page");
                        },
                        child: Text(
                          "Personal Records",
                          style: TextStyle(
                              fontFamily: 'PWBalloon',
                              fontSize: 30,
                              color: Colors.green,
                              fontWeight: FontWeight.w600),
                        ))
                  ]),
            ),
          ],
        ));
  }
}
