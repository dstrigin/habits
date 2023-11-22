import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habits/Habit.dart';
import 'package:habits/boxes.dart';
import 'package:habits/firebase_options.dart';
import 'package:habits/pages/home.dart';
import 'package:habits/pages/documentation.dart';
import 'package:habits/pages/history.dart';
import 'package:habits/pages/add_habit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'boxes.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  boxHabits = await Hive.openBox<Habit>('boxHabits');
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
        home:  homeNavyBar()
    );
  }
}

class homeNavyBar extends StatefulWidget {
  const homeNavyBar({super.key});

  @override
  State<homeNavyBar> createState() => _homeNavyBarState();
}

class _homeNavyBarState extends State<homeNavyBar> {
  @override
  Widget build(BuildContext context) {

    List<Widget> _buildScreens() {
        return [
          const HomePage(),
          const HistoryPage(),
          const AddHabit(),
          const Screen4(),
          const DocumentationPage(),
        ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [

            PersistentBottomNavBarItem(
                icon: const Icon(Icons.home),
                title: ("Home"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),

            PersistentBottomNavBarItem(
                icon: const Icon(Icons.history),
                title: ("History"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),

            PersistentBottomNavBarItem(
                icon: const Icon(Icons.add, color: Colors.blue),
                inactiveIcon: const Icon(Icons.add, color: Colors.grey),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),

            PersistentBottomNavBarItem(
                icon: const Icon(Icons.home),
                title: ("Home"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),

            PersistentBottomNavBarItem(
                icon: const Icon(Icons.book),
                title: ("Doc"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),
        ];
    }

    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
          NavBarStyle.style9,
    );
  }
}

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Screen4',
          style: TextStyle(fontSize: 30),
      ))
    );
  }
}
