import 'package:flutter/material.dart';
import 'package:iet_event_tracker/models/event_model.dart';
// no provider imports required here

class EventDetailScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(event.imageUrl, fit: BoxFit.cover, height: 220),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Chip(label: Text(event.category ?? '')),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 6),
                    Text(event.date.toLocal().toString()),
                  ]),
                  const SizedBox(height: 6),
                  Row(children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 6),
                    Text(event.location ?? event.venue ?? ''),
                  ]),
                  const SizedBox(height: 12),
                  Text(event.description ?? ''),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('You have registered for ${event.title}')),
                      );
                    },
                    child: const Text('Register Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
