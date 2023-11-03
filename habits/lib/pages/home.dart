import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: 
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgPicture.asset('assets/icons/hp_bar.svg')
          ],)
      ),
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
            fontWeight: FontWeight.bold 
          ),
        ),
      backgroundColor: Colors.cyan,
      elevation: 0.0,
      centerTitle: true,
      toolbarHeight: 65,
  );
}