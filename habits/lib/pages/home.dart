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
  Timer? dailyUpdateTimer;

  @override
  void initState() {
    super.initState();
    _initializeDailyUpdate();
  }

  void _initializeDailyUpdate() {
    _updateHealthForMissedDays();
    dailyUpdateTimer = Timer.periodic(const Duration(days: 1), (Timer t) => _updateHealthDaily());
  }

  void _updateHealthDaily() {
    _updateHealthBar();
  }

  void _updateHealthBar() {
    final box = Hive.box<Habit>('boxHabits');
    final healthBox = Hive.box('hpBarValue');


    double currentHealth = healthBox.get('healthBarValue', defaultValue: 0.95);


    double totalChange = box.values.fold(0.0, (sum, habit) => sum + (habit.type ? habit.damage : -habit.damage));


    double newValue = (currentHealth + totalChange).clamp(0.0, 1.0);


    setState(() {
      healthBox.put('healthBarValue', newValue);
    });
  }
  void _updateHealthForMissedDays() {
    final lastVisitTimestamp = boxLastVisit.get('lastVisitDate');
    final today = DateTime.now();
    boxLastVisit.put('lastVisitDate', today.millisecondsSinceEpoch);

    if (lastVisitTimestamp != null) {
      final lastVisitDate = DateTime.fromMillisecondsSinceEpoch(lastVisitTimestamp);
      final missedDays = today.difference(lastVisitDate).inDays;

      if (missedDays > 0) {
        for (int i = 0; i < missedDays; i++) {
          _updateHealthDaily();
        }
      }
    }
  }

  @override
  void dispose() {
    dailyUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 7, left: 3, right: 5),
            child: FutureBuilder(
              future: Future.value(Hive.box('hpBarValue').get('healthBarValue', defaultValue: 0.95)),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                double value = snapshot.data ?? 0.95;
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
                  padding: const EdgeInsets.only(top: 15, bottom: 7, left: 5, right: 5),
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Habit? hab = box.getAt(index);
                    return ListTile(
                      title: Text(hab!.id.toString(), style: const TextStyle(fontSize: 24)),
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
                              actionsPadding: const EdgeInsets.only(bottom: 20),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              title: const Text(
                                'Удалить привычку?',
                                style: TextStyle(fontSize: 28),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    box.delete(hab.key);
                                    boxTimestamps.put(
                                      'key_${hab.id}_removed',
                                      Stamp(
                                      habit: hab,
                                      time: DateTime.now(),
                                      added: false));
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(Icons.delete),
                                )
                              ],
                              actionsAlignment: MainAxisAlignment.center,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
