import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';
import 'package:habits/Habit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  late Box<Habit> habitBox = Hive.box<Habit>('boxHabits');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: histAppBar(),
      body: StreamBuilder<BoxEvent>(
        stream: habitBox.watch(), // следим за изменениями в Box
        builder: (context, snapshot) {
          return Column(children: [
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: Hive.box<Habit>('boxHabits').listenable(),
                    builder: (context, Box<Habit> box, _) {
                      if (habitBox.isEmpty) {
                        return const Center(
                          child: Text(
                            'Вы не добавили ни одной привычки, поэтому нечего показывать в истории',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      }
                      return ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 7, bottom: 7, left: 5, right: 5),
                          scrollDirection: Axis.vertical,
                          itemCount: habitBox.length,
                          itemBuilder: (context, index) {
                            Habit habit = habitBox.getAt(index)!;
                            return ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/${habit.icon}.svg',
                                width: 50,
                                height: 50,
                                alignment: Alignment.centerLeft,
                              ),
                              title: Text(
                                habit.id.toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                              onTap: () {

                              },
                            );
                          });
                    }))
          ]);
        },
      ),
    );
  }
}
