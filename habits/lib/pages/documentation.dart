import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: docAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Добро пожаловать в трекер привычек "habits"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'У нас есть одна цель - обратить внимание пользователей на свое здоровье через взгляд на свои привычки, и мы подбираемся к ней посредством разработки данного приложения.',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'На домашнем экране будут отображаться все привычки, которые у вас есть на данный момент.',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'Чтобы добавить привычку, нажмите на "плюс" - вы увидите список распространенных привычек, представленный нами, и сможете выбрать то, что подходит вам. Для этого нажмите на ее название и кнопку "добавить" во всплывшем окне.',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'Важно! Не стоит закрывать глаза на свои плохие привычки. Особенностью нашего приложения является наличие "полосы здоровья" - индикатора, который говорит вам о вашем состоянии в зависимости от количества и качества привычек.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'Когда вы выполняете какое-либо действие, связанное с определенной привычкой, нажмите на эту привычку на главном окне, если она регулярна для вас, или на экране со всеми привычками, выберете кнопку добавить. Полоса здоровья изменится.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'Об истории добавления привычек и изменениях полосы здоровья вы сможете посмотреть на второй странице приложения - "история".',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'Мы за то, чтобы вы узнавали что-то новое и интересное, поэтому пользователю предлагается ознакомиться с интересными фактами о какой-либо привычке на четвертой странице - "факт". Информация на ней будет обновляться каждый раз, когда вы заходите в приложение, так что вы всегда сможете подчерпнуть что-то для себя.',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'Если у вас есть вопросы или пожелания по поводу работы приложения - я с радостью готов с вами контактировать!',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                  launchUrl(
                    Uri.parse('https://t.me/dstrigin')
                  );
                },
              child: const Text(
              'tg: @dstrigin',
              style: TextStyle(
                fontSize: 24,
                color: Colors.cyan,
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
