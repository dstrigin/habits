// ignore_for_file: file_names

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
  @HiveField(4)
  late String icon;

  late String? fact;

  Habit({
    this.id = '',
    required this.description,
    required this.type,
    required this.damage,
    required this.icon,
    this.fact = ''
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'type': type,
    'damage': damage,
    'icon': icon,
    'fact' : fact
  };

  static Habit fromJson(Map<String, dynamic> json) => Habit(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      damage: json['damage'],
      icon: json['icon'],
      fact: json['fact']
  );
}

