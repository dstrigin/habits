
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/boxes.dart';
import 'package:habits/Habit.dart';
import 'package:hive_flutter/adapters.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar(),
      body: ListView.builder(
          itemCount: boxHabits.length,
          itemBuilder: (context, index){
              Habit hab = boxHabits.getAt(index);
            return ListTile(
              title: Text(hab.description.toString()),
              leading: IconButton(
                onPressed: (){
                  setState(() {
                    boxHabits.delete(hab.key);
                  });

                },
                icon: const Icon(Icons.delete),
              ),
              //leading: IconButton,
            );
          }
      )
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