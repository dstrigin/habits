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

                      // преобразовываем содержимое в список и сортируем по времени
                      List values = box.values.toList();
                      values.sort((x, y) => y.time.compareTo(x.time));
                      Stamp? stamp = values[index];

                      // в случае, если время представляет одноразрядное число
                      String day = '${stamp?.time.day}'.length == 1
                                  ? '0${stamp?.time.day}'
                                  : '${stamp?.time.day}';

                      String month = '${stamp?.time.month}'.length == 1
                          ? '0${stamp?.time.month}'
                          : '${stamp?.time.month}';

                      String hour = '${stamp?.time.hour}'.length == 1
                          ? '0${stamp?.time.hour}'
                          : '${stamp?.time.hour}';

                      String min = '${stamp?.time.minute}'.length == 1
                          ? '0${stamp?.time.minute}'
                          : '${stamp?.time.minute}';

                      Icon icon;

                      switch (stamp?.added) {
                        case "a":
                          icon = const Icon(Icons.add);
                          break;
                        case "d":
                          icon = const Icon(Icons.delete);
                          break;
                        default:
                          icon = const Icon(Icons.check);
                          break;
                      }

                      Icon showing = icon;

                      return ListTile(
                          contentPadding: const EdgeInsets.only(
                            top: 3, bottom: 3, left: 10, right: 5
                          ),
                          title: Text(
                            "$day/$month $hour:$min",
                            style: const TextStyle(fontSize: 24),
                          ),
                          leading: SvgPicture.asset(
                            'assets/icons/${stamp?.habit.icon}.svg',
                            width: 60,
                            height: 60,
                            alignment: Alignment.centerLeft,
                          ),
                          trailing: showing
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
