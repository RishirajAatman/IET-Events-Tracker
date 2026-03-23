import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../event_detail.dart';

class AdminExplore extends StatelessWidget {
  const AdminExplore({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/ietdavvlogo.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.school,
                      size: 20,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ),
            const Text('Explore (Admin)'),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: events.length,
        itemBuilder: (context, i) {
          final e = events[i];
          return Card(
            child: ListTile(
              leading: Image.asset(e.imageUrl,
                  width: 60, height: 60, fit: BoxFit.cover),
              title: Text(e.title),
              subtitle: Text(e.category ?? ''),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EventDetailScreen(event: e))),
            ),
          );
        },
      ),
    );
  }
}
