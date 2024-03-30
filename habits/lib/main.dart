import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habits/Habit.dart';
import 'package:habits/boxes.dart';
import 'package:habits/firebase_options.dart';
import 'package:habits/stamp.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habits/elements/homeNavyBar.dart';
final StreamController<double> healthBarController = StreamController<double>.broadcast();
Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(StampAdapter());

  
  boxHabits = await Hive.openBox<Habit>('boxHabits');
  boxTimestamps = await Hive.openBox<Stamp>('boxTimestamps');
  hpBarValue = await Hive.openBox("hpBarValue");
  boxLastVisit = await Hive.openBox('lastVisit');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Bahnschrift'),
        home:  const HomeNavyBar()
    );
  }
}
