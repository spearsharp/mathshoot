import 'dart:ffi';

import '../services/screeenAdapter.dart';
import "../routers/routers.dart";
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final Map arguments;
  const Profile({super.key, required this.arguments});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /// 邮箱正则
  final String regexEmail =
      "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ScreenAdapter = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/mainlist",
                  arguments: {"title": "profile"});
              print("1231231231231");
            },
            icon: Icon(Icons.chevron_left)),
        iconTheme: const IconThemeData(
          color: Colors.white70,
          // 设置返回箭头颜色为白色
        ),
        title: Row(
          children: [
            const Expanded(flex: 3, child: Text("")),
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/setting",
                              arguments: {"title": "mainlist"});
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white70,
                        ))))
          ],
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: _ScreenAdapter.width,
              height: _ScreenAdapter.height,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/game/matchbkgpic.jpg"))),
              child: Container(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  margin:
                      EdgeInsets.fromLTRB(0, _ScreenAdapter.height * 0.1, 0, 0),
                  child: Column(children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              // or bottomsheet to select .. dun use local pics
                              print("pending on select portrait pics");
                            },
                            child: Expanded(
                              flex: 1,
                              child: Container(
                                  height: 120,
                                  margin: EdgeInsets.all(8),
                                  // padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: Colors.white70, width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Image(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          "images/game/portrait/man4.png"))),
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Spear Yao",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white70,
                                                fontFamily: "CreamCake"),
                                          )
                                        ])),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        alignment: Alignment.centerLeft,
                                        onPressed: () {
                                          print("edit name");
                                        },
                                        icon: const Icon(
                                          Icons.mode,
                                          color: Colors.white70,
                                        )))
                              ],
                            ))
                      ],
                    ),
                    Expanded(
                      child: ListView(children: [
                        Container(
                            height: _ScreenAdapter.height * 0.1,
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.white70,
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                hoverColor: Colors.white70,
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white70,
                                ),
                                hintStyle: TextStyle(
                                    fontFamily: "Bollony",
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800),
                                hintText: "Email:",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                              ), // hint text ontap to update,tapout to save
                            )),
                        Container(
                            height: _ScreenAdapter.height * 0.1,
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                hoverColor: Colors.white70,
                                suffixIcon: Icon(
                                  Icons.date_range,
                                  color: Colors.white70,
                                ),
                                hintStyle: TextStyle(
                                    fontFamily: "Bollony",
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800),
                                hintText: "Age:",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                              ), // hint text ontap to update,tapout to save
                            )),
                        Container(
                            height: _ScreenAdapter.height * 0.1,
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                hoverColor: Colors.white70,
                                suffixIcon: Icon(
                                  Icons.people_alt_outlined,
                                  color: Colors.white70,
                                ),
                                hintStyle: TextStyle(
                                    fontFamily: "Bollony",
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800),
                                hintText: "Gender:",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                              ), // hint text ontap to update,tapout to save
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: Text(
                            "save",
                            style: TextStyle(
                                fontFamily: "Bollony",
                                color: Colors.amber[800],
                                fontSize: _ScreenAdapter.width * 0.1,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white30)),
                          onPressed: () {
                            print("save to server");
                          },
                        )
                      ]),
                    )
                  ]))),
        ],
      ),
    );
  }
}
