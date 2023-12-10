import '../main.dart';
import '../tabs/message.dart';
import 'package:flutter/material.dart';
import '../tabs/category.dart';
import '../tabs/home.dart';
import '../tabs/setting.dart';
import '../tabs/people.dart';
import '../utils/leftdrawer.dart';

class BottomTabs extends StatefulWidget {
  final int index;

  const BottomTabs({super.key, this.index = 0});

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  late int _currentindex;

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_null_comparison
    print(widget.index);
    _currentindex = widget.index;
    // if (widget.arguments["index"] != null) {
    //   _currentindex = widget.arguments["index"] as int;
    // } else {
    //   _currentindex = 0;
    // }
  }

  final List<Widget> _pages = [
    Home(),
    Category(),
    Message(),
    Setting(),
    People()
  ];
  @override
  Widget build(BuildContext context) {
    var _currtap;
    return Scaffold(
        appBar: AppBar(
          actions: const [],
          title: const Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "flutter app",
                  textAlign: TextAlign.center,
                ),
              ]),
          titleTextStyle: const TextStyle(
              fontSize: 30, color: Color.fromARGB(137, 112, 75, 75)),
        ),
        drawer: const Drawer(child: Drawerleft()),
        // endDrawer: const Drawer(child: Drawerright()),
        endDrawer: const Drawer(),
        body: _pages[_currentindex],
        // endDrawer: const Drawer(
        //     child: Column(children: [
        //   SizedBox(height: 20),
        //   ListTile(
        //       leading: CircleAvatar(child: Icon(Icons.people)),
        //       title: Text("个人中心"))
        // ])),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentindex = index;
                _currtap = index;
                print("_currentindex:");
                print(_currentindex);
                print("tabindex:");
                print(_currtap);
              });
            },
            currentIndex: _currentindex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: "category"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "message",
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: "setting"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline), label: "people"),
            ]),
        floatingActionButton: Container(
          height: 56,
          width: 56,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: FloatingActionButton(
              elevation: 0.0,
              highlightElevation: double.maxFinite,
              onPressed: () {
                setState(() {
                  _currentindex = 2;
                });
                // ignore: avoid_print
                print(_currtap);
              },
              child: const Icon(Icons.add)),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}

//Drawer Left
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
        // DrawerHeader(   // DrawerHeader without DrawerHeadACC
        //   decoration: const BoxDecoration(
        //       color: Colors.yellow,
        //       image: DecorationImage(
        //           // image: NetworkImage(
        //           //     "https://img9.doubanio.com/view/richtext/large/public/p113353176.jpg"),
        //           fit: BoxFit.cover,
        //           image: AssetImage("images/flutter_pers.jpg"))),
        //   child: ListView(
        //     children: const [Text("我是一个头部")],
        //   ),
        // ),
        ListTile(
            leading: CircleAvatar(child: Icon(Icons.access_time_outlined)),
            // onTap: HomePage(),
            title: Text("个人中心")),
        Divider(),
        ListTile(
            leading: CircleAvatar(child: Icon(Icons.access_time_outlined)),
            title: Text("系统设置"))
        // ListTile(
        //     container: (GridView.count(
        //         crossAxisCount: 3,
        //         // childAspectRatio: 1.0,
        //         children: [
        //       Icon(Icons.home),
        //       Icon(Icons.ac_unit),
        //       Icon(Icons.search),
        //       Icon(Icons.settings),
        //       Icon(Icons.airport_shuttle),
        //       Icon(Icons.all_inclusive),
        //       Icon(Icons.beach_access),
        //       Icon(Icons.cake),
        //       Icon(Icons.circle)
        //     ])))
      ],
    );
  }
}

//Drawer right
class Drawerright extends StatefulWidget {
  const Drawerright({super.key});

  @override
  State<Drawerright> createState() => _DrawerrightState();
}

class _DrawerrightState extends State<Drawerright> {
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
        // DrawerHeader(   // DrawerHeader without DrawerHeadACC
        //   decoration: const BoxDecoration(
        //       color: Colors.yellow,
        //       image: DecorationImage(
        //           // image: NetworkImage(
        //           //     "https://img9.doubanio.com/view/richtext/large/public/p113353176.jpg"),
        //           fit: BoxFit.cover,
        //           image: AssetImage("images/flutter_pers.jpg"))),
        //   child: ListView(
        //     children: const [Text("我是一个头部")],
        //   ),
        // ),
        ListTile(
            leading: CircleAvatar(child: Icon(Icons.access_time_outlined)),
            // onTap: HomePage(),
            title: Text("个人中心")),
        Divider(),
        ListTile(
            leading: CircleAvatar(child: Icon(Icons.access_time_outlined)),
            title: Text("系统设置"))
        // ListTile(
        //     container: (GridView.count(
        //         crossAxisCount: 3,
        //         // childAspectRatio: 1.0,
        //         children: [
        //       Icon(Icons.home),
        //       Icon(Icons.ac_unit),
        //       Icon(Icons.search),
        //       Icon(Icons.settings),
        //       Icon(Icons.airport_shuttle),
        //       Icon(Icons.all_inclusive),
        //       Icon(Icons.beach_access),
        //       Icon(Icons.cake),
        //       Icon(Icons.circle)
        //     ])))
      ],
    );
  }
}
