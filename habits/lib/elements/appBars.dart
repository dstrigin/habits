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

AppBar docAppBar() {
  return AppBar(
        title: const Text(
          'documentation.', 
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

AppBar histAppBar() {
  return AppBar(
        title: const Text(
          'history.', 
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
