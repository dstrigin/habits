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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 7, bottom: 7, left: 5, right: 5
            ),
            child: SvgPicture.asset(
              'assets/icons/hp_bar.svg',
              alignment: Alignment.center,
              width: 50,
              height: 30,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Habit>('boxHabits').listenable(),
              builder: (context, Box<Habit> box, _){
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
                    top: 7, bottom: 7, left: 5, right: 5
                  ),
                  itemCount: box.values.length,
                  itemBuilder: (context, index){
                    Habit? hab = box.getAt(index);
                    return ListTile(
                      title: Text(
                        hab!.id.toString(),
                        style: const TextStyle(fontSize: 24),
                      ),
                      leading: SvgPicture.asset(
                        'assets/icons/${hab.icon}.svg',
                        width: 50,
                        height: 50,
                        alignment: Alignment.centerLeft,
                      ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                              title: Text(
                                hab.id.toString(), 
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      boxHabits.delete(hab.key);
                                      boxTimestamps.put('key_${hab.id}_${Stamp.id}_removed',
                                          Stamp(
                                              habit: hab,
                                              time: DateTime.now(),
                                              added: false
                                          )
                                      );
                                    });
                                    Stamp.id++;
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(Icons.delete),
                                )
                              ],
                          );
                        }
                      );
                    },
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
