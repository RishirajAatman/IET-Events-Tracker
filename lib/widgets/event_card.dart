import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'asset_placeholder.dart';
// import '../theme/app_theme.dart'; // no longer used

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;
  const EventCard({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.96, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: child,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 1.2),
        ),
        elevation: 4,
        shadowColor: Colors.black
            .withAlpha((0.5 * 255).toInt()), // Corrected to use withAlpha
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: assetImageOrPlaceholder(
                  event.image ?? '', // Ensure null safety
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  title: event.title,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: Theme.of(context).colorScheme.primary,
                            size: 18),
                        const SizedBox(width: 6),
                        Text(
                          "${event.date.toLocal()}".split(' ')[0],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.location_on,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event.venue ??
                                'Unknown Venue', // Handle nullable venue
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
