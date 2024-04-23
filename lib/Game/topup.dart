import 'package:flutter/material.dart';

class TopUp extends StatefulWidget {
  final Map arguments;
  const TopUp({super.key, required this.arguments});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  //payment information auto fill in
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Topup money page",
          style: TextStyle(fontSize: 38, fontFamily: "MotleyForces"),
        ),
      ),
    );
  }
}
