import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: docAppBar(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Добро пожаловать в трекер привычек "habits"',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'У нас есть одна цель - обратить внимание пользователей на свое здоровье через взгляд на свои привычки, и мы подбираемся к ней посредством разработки данного приложения.',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Divider(color: Colors.cyan),
            Text(
              'На домашнем экране будут отображаться все привычки, которые у вас есть на данный момент.',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Text(
              'Чтобы добавить привычку, нажмите на "плюс" - вы увидите список распространенных привычек, представленный нами, и сможете выбрать то, что подходит вам. Для этого нажмите на ее название и кнопку "добавить" во всплывшем окне.',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 16),
            Text(
              'Важно! Не стоит закрывать глаза на свои плохие привычки. Особенностью нашего приложения является наличие "полосы здоровья" - индикатора, который говорит вам о вашем состоянии в зависимости от количества и качества привычек.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Text(
              'Об истории добавления привычек и ежедневных изменениях полосы здоровья вы сможете посмотреть на второй странице приложения - "история".',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 16),
            Text(
              'Если у вас есть вопросы или пожелания по поводу работы приложения - я с радостью готов с вами контактировать!',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            Divider(color: Colors.cyan),
            SizedBox(height: 8),
            Text(
              'tg: @dstrigin',
              style: TextStyle(fontSize: 18, color: Colors.cyan, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}
