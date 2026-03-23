import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool animate;

  const GlassCard({
    super.key,
    required this.child,
    this.radius = 20,
    this.padding,
    this.margin,
    this.onTap,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      elevation: 4,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
            color: kPrimary.withAlpha((0.10 * 255).toInt()), width: 1.5),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: child,
      ),
    );
    if (onTap != null) {
      card = InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: card,
      );
    }
    if (animate) {
      card = AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        child: card,
      );
    }
    return card;
  }
}
