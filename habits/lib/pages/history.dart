import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';
import 'package:habits/boxes.dart';
import 'package:habits/stamp.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: histAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Stamp>('boxTimestamps').listenable(),
              builder: (context, Box<Stamp> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text(
                      'Вы не добавили ни одной привычки.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                }
                return ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 7, bottom: 7, left: 5, right: 5),
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      //Stamp? stamp = box.getAt(index);
                      List values = box.values.toList();
                      values.sort((x, y) => y.time.compareTo(x.time));
                      Stamp? stamp = values[index];
                      return ListTile(
                          title: Text(
                            "${stamp!.time.day}/${stamp.time.month}/${stamp.time.year} ${stamp.time.hour}:${stamp.time.minute}",
                            style: const TextStyle(fontSize: 24),
                          ),
                          leading: SvgPicture.asset(
                            'assets/icons/${stamp.habit.icon}.svg',
                            width: 50,
                            height: 50,
                            alignment: Alignment.centerLeft,
                          ),
                          trailing: stamp.added
                              ? const Icon(Icons.add)
                              : const Icon(Icons.remove));
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
