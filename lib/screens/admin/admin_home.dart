import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../event_detail.dart';
import 'admin_event_form.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final events = provider.events;

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
            const Text('Admin - Events'),
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
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(e.imageUrl,
                  width: 60, height: 60, fit: BoxFit.cover),
              title: Text(e.title),
              subtitle: Text(e.category ?? ''),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AdminEventForm(event: e))),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.deleteEvent(e.id),
                ),
              ]),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EventDetailScreen(event: e))),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AdminEventForm())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
