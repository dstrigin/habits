import 'package:flutter/material.dart';

AppBar homeAppBar() {
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
