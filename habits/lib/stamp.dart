import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/Habit.dart';
import 'package:hive/hive.dart';

part 'stamp.g.dart';

@HiveType(typeId: 2)
class Stamp extends HiveObject{
  @HiveField(0)
  late Habit habit; // привычка
  @HiveField(1)
  late DateTime time; // время добавления
  @HiveField(2)
  late bool added; // добавлена - true / удалена - false

  Stamp({
    required this.habit,
    required this.time,
    required this.added,
  });

}
