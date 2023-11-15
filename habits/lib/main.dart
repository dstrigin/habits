import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habits/firebase_options.dart';
import 'package:habits/pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}):super(key:key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Bahnschrift'),
        home: const HomePageWithNavigationBar()
    );
  }
}
class HomePageWithNavigationBar extends StatefulWidget {
  const HomePageWithNavigationBar({Key? key}) : super(key: key);

  @override
  _HomePageWithNavigationBarState createState() => _HomePageWithNavigationBarState();
}

class _HomePageWithNavigationBarState extends State<HomePageWithNavigationBar> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Действие при нажатии на кнопку
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.cyan,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.sunny),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_open),
              label: '',
            ),
          ],
          onTap: (index) {
            setState(() {
                _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}