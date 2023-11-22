import 'package:cloud_firestore/cloud_firestore.dart';

class Habit{

  late String id;
  late String description;
  late bool type;
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