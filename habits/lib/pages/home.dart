import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habits/boxes.dart';
import 'package:habits/Habit.dart';
import 'package:habits/stamp.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:habits/elements/appBars.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 7, left: 3, right: 5),
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
                  value: value > 0.05 ? value : 0.05,
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
                                'Выберите действие',
                                style: TextStyle(fontSize: 28),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        final healthBox = Hive.box('hpBarValue');

                                        double currentHealth = healthBox.get('healthBarValue', defaultValue: 0.95);
                                        double change = hab.type ? hab.damage : -hab.damage;

                                        healthBox.put('healthBarValue', currentHealth + change);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(Icons.check)
                                ),
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
