import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';

class FactPage extends StatelessWidget {
  const FactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: factAppBar(),
      body: const Center(
        child: Text(
          'Здесь будет интересная информация о случайной привычке, которая будет меняться время от времени',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        )
      )
    );
  }
}
