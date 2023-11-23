import 'package:flutter/material.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Documentation',
          style: TextStyle(fontSize: 30),
        )
      )
    );
  }
}
