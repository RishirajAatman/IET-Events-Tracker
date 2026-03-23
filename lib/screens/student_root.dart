import 'package:flutter/material.dart';
import 'student/student_home.dart';
import 'student/explore_screen.dart';
import 'student/profile_screen.dart';

class StudentRootScreen extends StatefulWidget {
  const StudentRootScreen({super.key});

  @override
  State<StudentRootScreen> createState() => _StudentRootScreenState();
}

class _StudentRootScreenState extends State<StudentRootScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    StudentHome(),
    ExploreScreen(),
    StudentProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
