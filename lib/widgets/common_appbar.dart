import 'package:flutter/material.dart';

/// Modern AppHeader with logo, bold title, and clean background
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  const AppHeader({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 3,
      shadowColor: Colors.black.withAlpha((0.08 * 255).toInt()),
      centerTitle: centerTitle,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: CircleAvatar(
          backgroundColor: Theme.of(context)
              .colorScheme
              .primary
              .withAlpha((0.5 * 255).toInt()),
          radius: 20,
          child: Icon(Icons.event,
              color: Theme.of(context).colorScheme.primary, size: 28),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
