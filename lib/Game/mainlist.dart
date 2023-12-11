import 'package:arithg/services/screeenAdapter.dart';
import 'package:flutter/material.dart';
import '../Game/gamelvl1.dart';
import '../Game/gamelvl2.dart';

class Mainlist extends StatefulWidget {
  final Map arguments;
  const Mainlist({super.key, required this.arguments});

  @override
  State<Mainlist> createState() => _MainlistState();
}

class _MainlistState extends State<Mainlist> {
  int levelnum = 14;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: mainlistleftdrawer(),
      ),
      appBar: AppBar(
        title: const Text("Math Balloon"),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/game/blackboardbkgpic.jpg"))),
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.topCenter,
                height: 60,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('images/game/yellowtitlebelt.png'))),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      // height: 55,
                      // width: 60,
                      child: Image.asset(
                        "images/game/unlockedbluepic.png",
                        width: 50,
                        height: 60,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        child: const Text("level One",
                            style: TextStyle(
                              fontFamily: 'CreamCake',
                              fontSize: 50,
                            ),
                            textAlign: TextAlign.start))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mainlistleftdrawer() {
  return Container(
    child: const Center(
      child: Text("left drawer"),
    ),
  );
}
