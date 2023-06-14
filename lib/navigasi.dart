import 'package:flutter/material.dart';
import 'pages/percentagePage.dart';
import 'pages/profilePage.dart';
import 'pages/moodPage2.dart';
import 'pages/homePage.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({Key? key}) : super(key: key);
  int currentIndex = 3;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

const List<Widget> screens = [
  HomePage(),
  ProgressPage(),
  Habitspage(),
  ProfilePage()
];

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.red,
        selectedItemColor: const Color.fromARGB(255, 133, 100, 10),
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions), label: "Mood"),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: "Percentage"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
