// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/boxes.dart';
import 'package:habits/Habit.dart';
import 'package:habits/elements/appBars.dart';
import 'package:habits/stamp.dart';
import 'package:hive/hive.dart';
import '../main.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({Key? key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

Future<List<Habit>> getHabits() async {
  List<Habit> habits = [];

  try {
    // Получаем доступ к коллекции 'habits' в Firestore
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('habits').get();

    // Проходим по документам и извлекаем привычки
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
      documentSnapshot.data() as Map<String, dynamic>;
      Habit habit = Habit.fromJson(data);
      habits.add(habit);
    }

    habits.sort((a, b) => a.type == true? -1 : 1);

  } 
  catch (error) 
  {
    print('Ошибка при получении привычек: $error');
  }
  return habits;
}

class _AddHabitState extends State<AddHabit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Habit>> (
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
                } else if (snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                      child: Text(
                          'Данные о привычках обновляются...',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30))
                  );
                } else {
                  // Отображаем список привычек из базы данных
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 3, right: 5),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Habit habit = snapshot.data![index];
                      return ListTile(
                        contentPadding: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 10, right: 5
                        ),
                        leading: SvgPicture.asset(
                          'assets/icons/${habit.icon}.svg',
                          width: 60,
                          height: 60,
                          alignment: Alignment.centerLeft,
                        ),
                        title: Text(
                          habit.id.toString(),
                          style: const TextStyle(
                            fontSize: 24
                            )
                          ),
                        onTap: () {
                             showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  title:  Text(
                                    habit.id.toString(), 
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                      habit.description,
                                      style: const TextStyle(fontSize: 18)),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                              playSound(habit);
                                              double change = habit.type ? habit.damage : -habit.damage;
                                              final healthBox = Hive.box<double>('hpBarValue');
                                              double currentHealth = healthBox.get('healthBarValue') ?? 0.95;
                                              healthBox.put('healthBarValue', currentHealth + change);
                                             
                                              setState(() {
                                                boxTimestamps.put('key_${habit.id}_${Stamp.id}_marked',
                                                  Stamp(
                                                    habit: habit,
                                                    time: DateTime.now(),
                                                    added: "m"
                                                  )
                                                );
                                                Stamp.id++;
                                              });

                                              Navigator.of(context).pop();
                                            
                                          },
                                        child: const Text('Отметить')
                                    ),
                                    ElevatedButton(
                                      onPressed: () async{
                                        setState(() {
                                          if (!boxHabits.containsKey('key_${habit.id}'))
                                          {
                                            double newValue = habit.type ? habit.damage :-habit.damage;
                                            healthBarController.add(newValue);
                                            boxHabits.put('key_${habit.id}',
                                              Habit(
                                                  id:habit.id,
                                                  description:habit.description,
                                                  damage:habit.damage,
                                                  type:habit.type,
                                                  icon:habit.icon
                                              )
                                            );
                                            boxTimestamps.put('key_${habit.id}_${Stamp.id}_added',
                                              Stamp(
                                                  habit: habit,
                                                  time: DateTime.now(),
                                                  added: "a"
                                              )
                                            );
                                            Stamp.id++;
                                          }
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child:const Text('Добавить'),
                                    ),
                                  ],
                                  actionsAlignment: MainAxisAlignment.spaceAround,
                                );
                              }
                            );
                        }
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
