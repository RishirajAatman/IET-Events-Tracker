import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final mockEvents = [
      {
        'title': 'Tech Conference',
        'date': '2025-11-20',
      },
      {
        'title': 'Art Workshop',
        'date': '2025-11-22',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: ListView.builder(
        itemCount: mockEvents.length,
        itemBuilder: (context, index) {
          final event = mockEvents[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(event['title']!),
              subtitle: Text(event['date']!),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
