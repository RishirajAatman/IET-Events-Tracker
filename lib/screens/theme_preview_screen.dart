import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navbar.dart';

class ThemePreviewScreen extends StatelessWidget {
  const ThemePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Event Manager'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            decoration: const BoxDecoration(
              gradient: kMainGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: const Text(
              'Upcoming Events',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF7F5AF0)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          // Event cards list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(height: 18),
              itemBuilder: (context, i) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  leading: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: kMainGradient,
                    ),
                    child:
                        const Icon(Icons.event, color: Colors.white, size: 30),
                  ),
                  title: Text(
                    'Event Title ${i + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: const Text(
                    'Location \u2022 Date & Time',
                    style: TextStyle(color: Colors.black54),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade400),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        child: ModernNavBar(currentIndex: 0, onTap: (_) {}),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimary,
        onPressed: () {},
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ---
// This screen previews the modern theme: gradient header, glass cards, search bar, bottom nav, and glowing FAB.
// Use as a playground for theme tweaks and UI inspiration.
