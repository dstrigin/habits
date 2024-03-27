import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habits/boxes.dart';
import 'package:habits/Habit.dart';
import 'package:habits/main.dart';
import 'package:habits/stamp.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:habits/elements/appBars.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ValueNotifier<double> healthBarValueNotifier;
  @override
  void initState() {
    super.initState();
    final box = Hive.box('hpBarValue');
    double initialHealthBarValue = box.get('healthBarValue', defaultValue: 0.95);
    healthBarValueNotifier = ValueNotifier<double>(initialHealthBarValue);
    _initializeStream();
  }
  void _initializeStream() {
    healthBarController.stream.listen((double change) {
      double newValue = healthBarValueNotifier.value + change;
      newValue = newValue.clamp(0.0, 1.0); // Ограничиваем значение от 0 до 1
      healthBarValueNotifier.value = newValue;
      final box = Hive.box('hpBarValue');
      box.put('healthBarValue', newValue);
    });
  }
  @override
  void dispose() {
    healthBarValueNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(
        children: [
           Padding(
            padding:
                EdgeInsets.only(top: 20, bottom: 7, left: 3, right: 5),
            child: ValueListenableBuilder<double>(
              valueListenable: healthBarValueNotifier,
              builder: (context, value, child) {
                Color color;
                if (value >= 0.75) {
                  color = Colors.green;
                } else if (value >= 0.5) {
                  color = Colors.yellow;
                } else if (value >= 0.25) {
                  color = Colors.orange;
                } else {
                  color = Colors.red;
                }
                return LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 33,
                  value: value,
                );

              },
            ),
    ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Habit>('boxHabits').listenable(),
              builder: (context, Box<Habit> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text(
                      'Вы не добавили ни одной привычки.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                }
                return ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 7, left: 5, right: 5),
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Habit? hab = box.getAt(index);
                      return ListTile(
                        title: Text(
                          hab!.id.toString(),
                          style: const TextStyle(fontSize: 24),
                        ),
                        leading: SvgPicture.asset(
                          'assets/icons/${hab.icon}.svg',
                          width: 60,
                          height: 60,
                          alignment: Alignment.centerLeft,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  actionsPadding: const EdgeInsets.only(
                                      bottom: 20),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  title: const Text(
                                    'Удалить привычку?',
                                    style: TextStyle(
                                        fontSize: 28),
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          boxHabits.delete(hab.key);
                                          boxTimestamps.put(
                                              'key_${hab.id}_removed',
                                              Stamp(
                                                  habit: hab,
                                                  time: DateTime.now(),
                                                  added: false));
                                        });
                                        double healthChange = hab.type ? -hab.damage/4 : hab.damage;
                                        healthBarController.add(healthChange);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(Icons.delete),
                                    )
                                  ],
                                  actionsAlignment: MainAxisAlignment.center,
                                );
                              });
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
