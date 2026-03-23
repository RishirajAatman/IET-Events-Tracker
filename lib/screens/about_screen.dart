import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "🎤 IET Event Tracker App\n\nDeveloped in Flutter\n\nTracks upcoming college events and lets you register easily.",
            style: TextStyle(fontSize: 18, height: 1.4),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
