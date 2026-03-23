import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double radius;
  final EdgeInsetsGeometry padding;
  final bool expand;
  final bool animate;

  const GradientButton({
    super.key,
    required this.child,
    this.onPressed,
    this.radius = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    this.expand = false,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget btn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: padding,
        elevation: 3,
        shadowColor: Colors.black.withAlpha((0.5 * 255).toInt()),
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
      onPressed: onPressed,
      child: child,
    );
    if (expand) btn = SizedBox(width: double.infinity, child: btn);
    if (animate) {
      btn = AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: btn,
      );
    }
    return btn;
  }
}
