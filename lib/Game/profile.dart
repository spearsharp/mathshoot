import '../services/screeenAdapter.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final Map arguments;
  const Profile({super.key, required this.arguments});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _ScreenAdapter = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
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
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Image(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          "images/game/portrait/man4.png"))),
                            )),
                        const Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Spear Yao",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontFamily: "CreamCake"),
                                    )),
                                Expanded(flex: 1, child: Text("data"))
                              ],
                            ))
                      ],
                    ),
                  ]))),
          Container(
            child: ListView(
              children: const [
                SizedBox(
                  child: Text("123123"),
                ),
                SizedBox(child: Text("123")),
                SizedBox(child: Text("123"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
