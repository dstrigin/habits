import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: ListView(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 7, right: 7),
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: SvgPicture.asset(
                  'assets/icons/hp_bar.svg',
                  alignment: Alignment.center,
                  width: 50,
                  height: 30
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/cigarette.svg',
                  width: 40,
                  height: 40,
                  alignment: Alignment.centerLeft,
                ),
                const Text(
                  'Курение',
                  locale: Locale('ru'),
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
                IconButton(
                    onPressed: (){
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          content: Text('Употребление никотина(табак, электронные сигареты) сильно влияют на дыхательную систему и разрушают легкие.'),
                        );

                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/info.svg',
                      alignment: Alignment.centerRight,
                      width: 50,
                      height: 50
                    ),

                )
              ],
            ),
          ],
        )
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