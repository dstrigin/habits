import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/boxes.dart';
//import 'package:habits/model.dart';
import 'home.dart';
import 'package:hive/hive.dart';
import 'package:habits/Habit.dart';



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
  } catch (error) {
    print('Ошибка при получении привычек: $error');
  }
  return habits;
}

class _AddHabitState extends State<AddHabit> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    initFirebase();
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Habit>>(
              future: getHabits(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Ошибка: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return Text('Нет данных о привычках');
                } else {
                  // Отображаем список привычек из базы данных
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 7, right: 7),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length, // Используйте snapshot.data!
                    itemBuilder: (context, index) {
                      Habit habit = snapshot.data![index]; // Используйте snapshot.data!
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/cigarette.svg',
                            width: 40,
                            height: 40,
                            alignment: Alignment.centerLeft,
                          ),
                          Text(
                            habit.id,
                            locale: Locale('ru'),
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  boxHabits.put('key_${habit.id.toString()}',
                                      Habit(
                                          id:habit.id,
                                          description:habit.description,
                                          damage:habit.damage,
                                          type:habit.type));
                                });
                              },
                              icon: const Icon(Icons.add)),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(habit.description),
                                  );
                                },
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/info.svg',
                              alignment: Alignment.centerRight,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
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
