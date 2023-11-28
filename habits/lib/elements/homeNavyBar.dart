// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:habits/pages/home.dart';
import 'package:habits/pages/documentation.dart';
import 'package:habits/pages/history.dart';
import 'package:habits/pages/fact.dart';
import 'package:habits/pages/add_habit.dart';

/* Класс навигационной панели на главном экране.
  Обеспечивает доступ к пяти экранам, переходы между ними. */

class HomeNavyBar extends StatefulWidget {
  const HomeNavyBar({super.key});

  @override
  State<HomeNavyBar> createState() => _homeNavyBarState();
}

class _homeNavyBarState extends State<HomeNavyBar> {
  @override
  Widget build(BuildContext context) {

    List<Widget> _buildScreens() {
        return [
          const HomePage(),
          const HistoryPage(),
          const AddHabit(),
          const FactPage(),
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
                icon: const Icon(Icons.question_mark),
                title: ("Fact"),
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

    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
        context,
        controller: controller,
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
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
          NavBarStyle.style9,
    );
  }
}
