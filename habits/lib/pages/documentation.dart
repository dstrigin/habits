import 'package:flutter/material.dart';
import 'package:habits/elements/appBars.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: docAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(left: 5, top:10, bottom: 12),
        children: [
          RichText(
            text: const TextSpan(
            style: TextStyle(fontSize: 24, color: Colors.black, fontFamily: 'Bahnschrift'),
            children: <TextSpan> [
              TextSpan(text: '    Добро пожаловать в трекер привычек ',),
              TextSpan(text: '"habits."', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '!\n\n    У нас есть одна цель - обратить внимание пользователей на свое здоровье через взгляд на свои привычки, и мы подбираемся к ней посредством разработки данного приложения.\n\n    На ',),
              TextSpan(text: 'домашнем экране', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' будут отображаться все привычки, которые у вас есть на данный момент. Вы можете прочитать их описание нажав на кнопку справа.\n\n    Чтобы добавить привычку нажмите на '),
              TextSpan(text: '"плюс"', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' - вы увидите список распространенных привычек, представленный нами, и сможете выбрать то, что подходит вам (а в поздних версиях - создать свою привычку).\n\n'),
              TextSpan(text: '    Важно!', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' Не стоит закрывать глаза на свои плохие привычки. Особенностью нашего приложения является наличие '),
              TextSpan(text: '"полосы здоровья"', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' - индикатора, который говорит вам о вашем состоянии в зависимости от количества и качества привычек.\n\n    Об истории добавления привычек и ежедневных изменениях полосы здоровья вы сможете посмотреть на второй странице приложения - '),
              TextSpan(text: '"история"', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '.\n\n    Если у вас есть вопросы или пожелания по поводу работы приложения - я с радостью готов с вами контактировать!\n\n    tg: @dstrigin  '),
              ]
            )
          ),
        ]
      )
    );
  }
}
