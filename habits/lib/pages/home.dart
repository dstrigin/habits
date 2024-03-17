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
  double healthBarValue=0.95;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(
        children: [
           Padding(
            padding:
                EdgeInsets.only(top: 20, bottom: 7, left: 3, right: 5),
            child: StreamBuilder<double>(
              stream: healthBarController.stream,
              initialData: healthBarValue,
              builder: (context,snapshot){
                if (snapshot.hasData)
                  {
                    healthBarValue=(healthBarValue + snapshot.data!).clamp(0.0, 1.0);
                  }
                return LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  backgroundColor: Colors.cyan,
                    minHeight: 33,
                  value:healthBarValue,
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
                                        double healthChange = hab!.type ? -hab.damage : hab.damage;
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
