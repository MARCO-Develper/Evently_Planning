import 'package:evently/screens/create_event.dart';
import 'package:evently/screens/home/tabs/home_tab/home_tab.dart';
import 'package:evently/screens/home/tabs/favorite_tab.dart';
import 'package:evently/screens/home/tabs/map_tab.dart';
import 'package:evently/screens/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateEvent.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(
                top: selectedIndex == 0 ? 4 : 0,
              ),
              child: const ImageIcon(
                AssetImage("assets/images/icons/Home 2.png"),
                size: 24,
              ),
            ),
            activeIcon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: ImageIcon(
                AssetImage("assets/images/icons/Home 1.png"),
                size: 24,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(
                top: selectedIndex == 1 ? 4 : 0,
              ),
              child: const ImageIcon(
                AssetImage("assets/images/icons/Map_Pin.png"),
                size: 24,
              ),
            ),
            activeIcon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: ImageIcon(
                AssetImage("assets/images/icons/Map_Pin2.png"),
                size: 24,
              ),
            ),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(
                top: selectedIndex == 2 ? 4 : 0,
              ),
              child: const ImageIcon(
                AssetImage("assets/images/icons/Heart.png"),
                size: 24,
              ),
            ),
            activeIcon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: ImageIcon(
                AssetImage("assets/images/icons/Heart2.png"),
                size: 24,
              ),
            ),
            label: "Love",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(
                top: selectedIndex == 3 ? 4 : 0,
              ),
              child: const ImageIcon(
                AssetImage("assets/images/icons/User_01.png"),
                size: 24,
              ),
            ),
            activeIcon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: ImageIcon(
                AssetImage("assets/images/icons/User_02.png"),
                size: 24,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    const MapTab(),
    const FavoriteTab(),
    const ProfileTab(),
  ];
}
