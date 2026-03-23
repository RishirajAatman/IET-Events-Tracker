import 'package:flutter/material.dart';
import 'homepage_clean.dart';

/// Thin compatibility wrapper so other files that import `homepage.dart`
/// still work. It simply delegates to `HomepageClean`.
class Homepage extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  const Homepage({super.key, this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return HomepageClean(userName: userName, userEmail: userEmail);
  }
}
