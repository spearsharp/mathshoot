import 'package:arithg/routers/routers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../services/screeenAdapter.dart';
import 'package:flutter/material.dart';

class GameMain extends StatefulWidget {
  const GameMain({Key? key}) : super(key: key);

  @override
  State<GameMain> createState() => _GameMainState();
}

class _GameMainState extends State<GameMain> {
  var _assetAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
    _assetAudioPlayer.open(
      Audio('audios/mainenteranceBGM.wav'),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.single,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _assetAudioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width;
    return Scaffold(
      drawer: const Drawer(child: Drawerleft()),
      backgroundColor: Colors.transparent,
      // appBar: AppBar(),
      body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/game/animatedballonbackgroumdpic.gif"),
          )),
          child: Stack(alignment: Alignment.topCenter, children: [
            const SizedBox(
              height: 30.0,
            ),
            Container(
                child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/gamelvl1",
                        arguments: {"title": "mainpage"});
                  },
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage("images/game/yellowtitlebelt.png"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/gamelvl1",
                        arguments: {"title": "mainpage"});
                  },
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage("images/game/yellowtitlebelt.png"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/gamelvl1",
                        arguments: {"title": "mainpage"});
                  },
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage("images/game/yellowtitlebelt.png"),
                  ),
                )
              ],
            ))
          ])),
    );
  }
}

class Drawerleft extends StatefulWidget {
  const Drawerleft({super.key});

  @override
  State<Drawerleft> createState() => _DrawerleftState();
}

class _DrawerleftState extends State<Drawerleft> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("Spear 老师"),
          accountEmail: Text("spear.yao@goldmanfuks.com"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage("images/portrait.jpg"),
          ),
          decoration: BoxDecoration(
              color: Colors.yellow,
              image: DecorationImage(
                  image: AssetImage("images/flutter_pers.jpg"),
                  // image: NetworkImage(// child:ClipOval()  实现圆形图片
                  //     "https://www.itying.com/images/flutter/1.png"),
                  fit: BoxFit.cover)),
        ),
        ListTile(
            leading: CircleAvatar(child: Icon(Icons.access_time_outlined)),
            // onTap: HomePage(),
            title: Text("个人中心")),
        Divider(),
        ListTile(
            leading: CircleAvatar(child: Icon(Icons.access_time_outlined)),
            title: Text("系统设置"))
      ],
    );
  }
}
