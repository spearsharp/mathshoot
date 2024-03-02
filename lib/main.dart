import '../Game/gamemain.dart';
import 'package:flutter/material.dart';
import 'Game/gamemain.dart';
import 'routers/routers.dart';

void main() {
  runApp(const MyApp());
  print("test_print");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(primaryColor: Colors.transparent),
        onGenerateRoute: onGernerateRoute,
        home: const GameMain());
  }
}
