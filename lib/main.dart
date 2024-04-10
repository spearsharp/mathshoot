import '../Game/gamemain.dart';
import 'package:flutter/material.dart';
import 'Game/gamemain.dart';
import 'routers/routers.dart';

void main() {
  //sharedpreference local storage checking -- pending local storage read/write auth,then run app,local data health check
  runApp(const MyApp());
  print("test_print");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //1. initial the app within DB,env,cat,healthchk,deployment preparation,screen size adjustment
//2. deviceinfo collect
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      // theme: ThemeData(
      //   primarySwatch: Colors.amber[700],
      // ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //sizefit.initialized -- pending
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(primaryColor: Colors.transparent),
        onGenerateRoute: onGernerateRoute,
        home: const GameMain());
  }
}
