import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
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

class _HomePageState extends State<HomePage> {
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
          // Ваш HP бар здесь
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              'assets/icons/hp_bar.svg',
              alignment: Alignment.center,
              width: 50,
              height: 30,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Habit>>(
              future: getHabits(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Отображаем индикатор загрузки
                } else if (snapshot.hasError) {
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
                              onPressed: () {}, icon: Icon(Icons.add)),
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

AppBar appBar() {
  return AppBar(
    title: const Text(
      'habits.',
      style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.cyan,
    elevation: 0.0,
    centerTitle: true,
    toolbarHeight: 65,
  );
}