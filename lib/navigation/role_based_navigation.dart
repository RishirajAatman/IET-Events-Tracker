import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/student_home.dart';
import '../screens/admin_dashboard.dart';

class RoleBasedNavigation extends StatelessWidget {
  const RoleBasedNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole = context.watch<AuthProvider>().userRole;

    if (userRole == 'admin') {
      return const AdminDashboard(
        userName: 'Admin User',
        userEmail: 'admin@example.com',
      );
    } else {
      return const StudentHome();
    }
  }
}
