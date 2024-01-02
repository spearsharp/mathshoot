import '../services/screeenAdapter.dart';
import 'package:flutter/material.dart';

class Guide extends StatefulWidget {
  final Map arguments;
  const Guide({super.key, required this.arguments});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
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
            Center(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(18),
                margin: EdgeInsets.all(20),
                child: const Text.rich(
                  TextSpan(
                      text:
                          "             Operation Guide                       "
                          "This is a fun game for child and adult"),
                  style: TextStyle(
                      fontSize: 25,
                      // fontFamily: "MotleyForces",
                      fontStyle: FontStyle.italic,
                      color: Colors.white60,
                      fontWeight: FontWeight.w800),
                ),
              ),
            )
          ])),
    );
  }
}
