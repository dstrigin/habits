import 'dart:convert';
import 'package:hive/hive.dart';

part 'Habit.g.dart';

@HiveType(typeId: 1)
class Habit extends HiveObject{
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late bool type;
  @HiveField(3)
  late double damage;

  Habit({
    this.id = '',
    required this.description,
    required this.type,
    required this.damage
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'type': type,
    'damage': damage,
  };

  static Habit fromJson(Map<String, dynamic> json) => Habit(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      damage: json['damage']
  );
}

