import '../widgets/fade_slide.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/event_model.dart';
import '../widgets/asset_placeholder.dart';
import '../widgets/common_appbar.dart';
import '../widgets/gradient_button.dart';
// import '../theme/app_theme.dart'; // no longer used

class EventDetailScreen extends StatelessWidget {
  final EventModel event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppHeader(
        title: 'Event Details',
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero image with fade/slide
            FadeSlide(
              delayMs: 0,
              child: Hero(
                tag: 'event_image_${event.title}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  child: SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: assetImageOrPlaceholder(
                      event.image ?? '', // Ensure null safety
                      fit: BoxFit.cover,
                      title: event.title,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Modern card for event details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.outline, width: 1.2),
                ),
                shadowColor: Colors.black.withAlpha((0.08 * 255).toInt()),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeSlide(
                        delayMs: 80,
                        child: Text(
                          event.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Blue chip
                      FadeSlide(
                        delayMs: 120,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            event.category ??
                                'Uncategorized', // Ensure null safety
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      FadeSlide(
                        delayMs: 160,
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(event.date.toLocal().toString().split(' ')[0],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      FadeSlide(
                        delayMs: 200,
                        child: Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 18,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 8),
                            Text(
                                event.venue ??
                                    'Unknown Venue', // Handle nullable venue
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      FadeSlide(
                        delayMs: 240,
                        child: Row(
                          children: [
                            Icon(Icons.person,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text('Coordinator: ${event.coordinator}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      FadeSlide(
                        delayMs: 280,
                        child: Text(
                          event.description ??
                              'No description available', // Ensure null safety
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      FadeSlide(
                        delayMs: 340,
                        child: GradientButton(
                          expand: true,
                          onPressed: () async {
                            final url = Uri.parse(event.registrationLink ??
                                ''); // Ensure null safety
                            final messenger = ScaffoldMessenger.of(context);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Could not open the registration link.'),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Register Now',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
