import 'package:flutter/material.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
      body: Center(
        child: Text(
          'Add Habit',
          style: TextStyle(fontSize: 30),
        )
      )
    );
  }
}