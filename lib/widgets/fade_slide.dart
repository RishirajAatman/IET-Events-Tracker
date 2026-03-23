import 'package:flutter/material.dart';

/// FadeSlide animates its child with a fade and upward slide.
class FadeSlide extends StatefulWidget {
  final Widget child;
  final int delayMs;
  final double offsetY;
  final Duration duration;

  const FadeSlide({
    super.key,
    required this.child,
    this.delayMs = 0,
    this.offsetY = 24.0,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<FadeSlide> createState() => _FadeSlideState();
}

class _FadeSlideState extends State<FadeSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offsetY / 40),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (widget.delayMs > 0) {
      Future.delayed(
          Duration(milliseconds: widget.delayMs), _controller.forward);
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
