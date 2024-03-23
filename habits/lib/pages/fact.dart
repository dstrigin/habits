import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habits/elements/appBars.dart';

class FactPage extends StatelessWidget {
  const FactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: factAppBar(),
        body: Column(
          children: [
            SvgPicture.asset('assets/icons/diet.svg', width: 240),
            const Text(
              'Здесь будет интересная информация о случайной привычке, которая будет меняться время от времени',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            FilledButton(
              onPressed: () {},
              
              child: Text('да'),
            )
          ],
        ));
  }
}
