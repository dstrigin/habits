import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';
import 'package:habits/stamp.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Box<Stamp> boxTimestamps;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: histAppBar(),
        body: Column(children: [
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Stamp>('boxTimestamps').listenable(),
                  builder: (context, Box<Stamp> box, _) {
                    if (box.isEmpty) {
                      return const Center(
                        child: Text(
                          'Попробуйте добавить привычку.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }
                    return ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 7, bottom: 7, left: 5, right: 5),
                        scrollDirection: Axis.vertical,
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          Stamp? stamp = box.getAt(index)!;
                          return ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/${stamp.habit.icon}.svg',
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            title: Text(
                              stamp.time.toString(),
                              style: const TextStyle(fontSize: 24),
                            ),
                            trailing: stamp.added
                                ? const Icon(Icons.add)
                                : const Icon(Icons.remove),
                            onTap: () {
                              // TODO
                            },
                          );
                        });
                  }))
        ]));
  }
}
