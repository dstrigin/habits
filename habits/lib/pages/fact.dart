import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habits/Habit.dart';
import 'package:habits/elements/appBars.dart';
import 'package:habits/pages/add_habit.dart';

class FactPage extends StatefulWidget {
  const FactPage({super.key});

  @override
  State<FactPage> createState() => _FactPageState();
}

class _FactPageState extends State<FactPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: factAppBar(),
      body: Column (
        children: [
          Expanded(
              child: FutureBuilder<List<Habit>>(
                future: getHabits(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  } else if ( snapshot.hasData && snapshot.data == null) {
                    return const Center(
                      child: Text(
                        'Данные о привычках отсутствуют',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30))
                    );
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(
                        'Данные о привычках обновляются...',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30))
                    );
                  } else {
                    return ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 7, left: 3, right: 5),
                        scrollDirection: Axis.vertical,
                        //itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {

                        }
                    );
                }}
              )
          )
        ],
      )
    );
  }
}
