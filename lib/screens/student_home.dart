import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../widgets/asset_placeholder.dart';
import 'event_detail.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final featuredEvents = provider.featuredEvents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Home'),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CarouselSlider.builder(
              itemCount: featuredEvents.length,
              itemBuilder: (context, index, realIdx) {
                final event = featuredEvents[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      assetImageOrPlaceholder(event.imageUrl,
                          fit: BoxFit.cover, title: event.title),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withAlpha((0.4 * 255).toInt()),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        right: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Chip(
                                label: Text(event.category ?? ''),
                                backgroundColor: Colors.white70),
                            const SizedBox(height: 6),
                            Text(event.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(event.date.toLocal().toString().split(' ')[0],
                                style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                  height: 200, autoPlay: true, enlargeCenterPage: true),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Upcoming Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...provider.upcomingEvents.map((event) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: assetImageOrPlaceholder(event.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        title: event.title),
                  ),
                  title: Text(event.title),
                  subtitle: Text(
                      '${event.category ?? ''} • ${event.date.toLocal().toString().split(' ')[0]}\n${event.location ?? event.venue ?? ''}'),
                  isThreeLine: true,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EventDetailScreen(event: event))),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
