import 'package:application/screens/animation/animation_page.dart';
import 'package:application/screens/map/screens/map_page.dart';
import 'package:application/screens/news/screens/news_page.dart';
import 'package:application/screens/profile/screens/profile_page.dart';
import 'package:application/screens/qr/qr_page.dart';
import 'package:application/services/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  late final CupertinoTabController tabController = CupertinoTabController();

  final List screens = const [
    NewsPage(),
    QRScanner(),
    MapPage(),
    AnimationPage(),
    ProfilePage()
  ];

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) async {
    Utils.disableScanner(index);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        activeColor: Colors.white,
        inactiveColor: const Color.fromARGB(255, 117, 117, 117),
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "QR",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: "Map",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.animation),
            label: "Animation",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: "Profile",
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return screens[index];  
      },
    );
  }
}