import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habits/Habit.dart';
import 'package:habits/elements/appBars.dart';
import 'package:habits/pages/add_habit.dart';
import 'dart:math';

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
                        'Подбираем случайный факт...',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30))
                    );
                  } else {
                    int ind = Random().nextInt(snapshot.data!.length);
                    return ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 15, left: 20, right: 20),
                        scrollDirection: Axis.vertical,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          Habit habit = snapshot.data![ind];
                          return ListBody(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    habit.id,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/${habit.icon}.svg',
                                    width: 240,
                                    height: 240,
                                  ),
                                  Text(
                                    '\n${habit.fact}\n',
                                    style: const TextStyle(
                                        fontSize: 24
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            ],
                          );
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
