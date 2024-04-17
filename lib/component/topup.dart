import 'package:flutter/material.dart';

class strip extends StatefulWidget {
  const strip({super.key});

  @override
  State<strip> createState() => _stripState();
}

class _stripState extends State<strip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("stripe"),
      ),
      body: const Center(
        child: Text("Stripe"),
      ),
    );
  }
}
