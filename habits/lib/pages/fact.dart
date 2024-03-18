import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habits/elements/appBars.dart';

class FactPage extends StatelessWidget {
  const FactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: factAppBar(),
      body: Container(
        child: SvgPicture.asset(
          'assets/icons/diet.svg',
          width: 240),
        margin: EdgeInsets.symmetric(horizontal: 86.0, vertical: 55.0)
      ),

    );
  }
}
