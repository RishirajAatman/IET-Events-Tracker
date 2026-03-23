import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Helper widget to load an asset image and show a graceful placeholder if the
/// asset is missing or fails to load. Use this instead of raw Image.asset
/// when your assets may be absent during development.
Widget assetImageOrPlaceholder(
  String assetPath, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  String? title,
}) {
  // If the asset is an SVG, use SvgPicture.asset for better rendering
  if (assetPath.toLowerCase().endsWith('.svg')) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (context) {
        final bg = Colors.grey.shade300;
        final initials = (title ?? '').isNotEmpty
            ? (title!
                .split(' ')
                .map((s) => s.isNotEmpty ? s[0] : '')
                .take(2)
                .join())
            : '?';

        return Container(
          width: width,
          height: height,
          color: bg,
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: Text(initials, style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  return Image.asset(
    assetPath,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      // Show a colored box with initials (from title) when image isn't available
      final bg = Colors.grey.shade300;
      final initials = (title ?? '').isNotEmpty
          ? (title!
              .split(' ')
              .map((s) => s.isNotEmpty ? s[0] : '')
              .take(2)
              .join())
          : '?';

      return Container(
        width: width,
        height: height,
        color: bg,
        alignment: Alignment.center,
        child: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(initials, style: const TextStyle(color: Colors.white)),
        ),
      );
    },
  );
}
