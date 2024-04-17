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
  late String added; // добавлена - "a" / удалена - "d" / отмечена - "m"

  static int id = 0;

  Stamp({
    required this.habit,
    required this.time,
    required this.added,
  });

}
