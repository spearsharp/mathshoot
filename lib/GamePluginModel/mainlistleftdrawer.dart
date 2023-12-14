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
        height: _screenAdapter.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.5,
                image: AssetImage("images/game/agrorithbkgpic.jpg"))),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Touch Sound",
                      style: TextStyle(
                          fontFamily: 'Ballony',
                          fontSize: 25,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
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
              padding: EdgeInsets.all(15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Game Sound",
                      style: TextStyle(
                          fontFamily: 'Ballony',
                          fontSize: 25,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
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
              padding: EdgeInsets.all(15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Background Sound",
                      style: TextStyle(
                          fontFamily: 'Ballony',
                          fontSize: 25,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
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
              padding: EdgeInsets.all(20),
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
                              backgroundColor:
                                  Color.fromRGBO(242, 239, 239, 0.4),
                              fontFamily: 'PWBalloon',
                              fontSize: 35,
                              color: Colors.green,
                              fontWeight: FontWeight.w800),
                        ))
                  ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Text("advertisment"), // pending advertisment
              ),
            )
          ],
        ));
  }
}
