import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../widgets/glass_card.dart'; // no longer used
import '../widgets/gradient_button.dart';
// import '../theme/app_theme.dart'; // no longer used

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  const ProfileScreen(
      {super.key,
      required this.name,
      required this.email,
      this.role = 'student'});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userType');
    if (!context.mounted) return; // Ensure context is still valid
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e[0]).take(2).join()
        : 'IET';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/ietdavvlogo.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.school,
                      size: 20,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ),
            const Text('Profile'),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 48,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                initials,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(178),
                  ),
            ),
            const SizedBox(height: 24),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              elevation: 3,
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person_outline,
                        color: Theme.of(context).colorScheme.primary),
                    title: const Text('Name'),
                    subtitle: Text(name),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.mail_outline,
                        color: Theme.of(context).colorScheme.secondary),
                    title: const Text('Email'),
                    subtitle: Text(email),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.verified_user,
                        color: Theme.of(context).colorScheme.primary),
                    title: const Text('Role'),
                    subtitle: Text(role),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            GradientButton(
              expand: true,
              onPressed: () => _logout(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout, color: Colors.white),
                  const SizedBox(width: 10),
                  Text('Logout',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
