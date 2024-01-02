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
  Widget build(BuildContext context) {
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
                          print("123");
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
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/game/matchbkgpic.jpg"))),
          child: ListView(children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  width: ScreenAdapter.width(150),
                  height: ScreenAdapter.height(150),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                      onTap: () {
                        print(
                            "link to local pic select"); // or bottomsheet to select .. dun use local pics
                      },
                      child: const Image(
                          image: AssetImage("images/game/portrait/man4.png"))),
                )),
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                        child: Text(
                      "Spear Yao",
                      style: TextStyle(
                          fontSize: ScreenAdapter.width(30),
                          fontFamily: "CreamCake"),
                    )),
                    const Expanded(child: Text("data"))
                  ],
                ))
              ],
            ),
            ListView(
              children: const [
                SizedBox(
                  child: Text("123123"),
                ),
                SizedBox(child: Text("123")),
                SizedBox(child: Text("123"))
              ],
            )
          ])),
    );
  }
}
