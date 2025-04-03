import 'package:flutter/material.dart';
import '../create_event.dart';
import 'tabs/home_tab/home_tab.dart';
import 'tabs/love_tab.dart';
import 'tabs/map_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

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
          selectedIndex = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken_outlined), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: ""),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    const MapTab(),
    const LoveTab(),
    const ProfileTab(),
  ];
}
