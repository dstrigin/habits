import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: histAppBar(),
      body: const Center(
        child: Text(
          'History',
          style: TextStyle(fontSize: 30),
        )
      )
    );
  }
}
