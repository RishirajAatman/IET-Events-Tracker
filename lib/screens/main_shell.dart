import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'homepage_clean.dart';
import 'admin_dashboard.dart';
import 'explore_screen.dart';
import 'student/profile_screen.dart';

/// MainShell provides a bottom navigation shell for the app with three tabs:
/// Home, Profile, and About. This keeps navigation simple and responsive.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  final bool _isAdmin = false; // Made _isAdmin final

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Both HomepageClean and AdminDashboard use Provider.of<EventProvider>(context)
    final List<Widget> pages = <Widget>[
      _isAdmin
          ? const AdminDashboard(userName: 'Admin', userEmail: 'admin@iet.com')
          : const HomepageClean(),
      const ExploreScreen(),
      const StudentProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: ModernNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
