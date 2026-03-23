import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event_model.dart';
import 'add_edit_event_screen.dart';
import '../providers/event_provider.dart';
import 'profile_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard(
      {super.key, required this.userName, required this.userEmail});
  final String userName;
  final String userEmail;

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  void _addEvent() async {
    final newEvent = await Navigator.push<EventModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddEditEventScreen()),
    );
    if (!mounted) return;
    if (newEvent != null) {
      context.read<EventProvider>().addEvent(newEvent);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event added successfully!')),
      );
    }
  }

  void _editEvent(EventModel event) async {
    final updated = await Navigator.push<EventModel>(
      context,
      MaterialPageRoute(builder: (context) => AddEditEventScreen(event: event)),
    );
    if (!mounted) return;
    if (updated != null) {
      context.read<EventProvider>().editEvent(updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event updated successfully!')),
      );
    }
  }

  void _deleteEvent(EventModel event) {
    context.read<EventProvider>().deleteEvent(event.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Event deleted: ${event.title}')), // Added event title for clarity
    );
  }

  @override
  Widget build(BuildContext context) {
    final events = context.watch<EventProvider>().events;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                    name: widget.userName,
                    email: widget.userEmail,
                    role: 'admin',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        tooltip: 'Add Event',
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(event.imageUrl),
              ),
              title: Text(event.title),
              subtitle: Text(event.date.toLocal().toString().split(' ')[0]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editEvent(event),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteEvent(event),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
