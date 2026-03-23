import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event_model.dart';
import '../../providers/event_provider.dart';

class AdminEventForm extends StatefulWidget {
  final EventModel? event;

  const AdminEventForm({super.key, this.event});

  @override
  State<AdminEventForm> createState() => _AdminEventFormState();
}

class _AdminEventFormState extends State<AdminEventForm> {
  late final TextEditingController _title;
  late final TextEditingController _category;
  late final TextEditingController _date;
  late final TextEditingController _location;
  late final TextEditingController _image;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.event?.title ?? '');
    _category = TextEditingController(text: widget.event?.category ?? '');
    _date =
        TextEditingController(text: widget.event?.date.toIso8601String() ?? '');
    _location = TextEditingController(
        text: widget.event?.location ?? widget.event?.venue ?? '');
    _image = TextEditingController(
        text: widget.event?.imageUrl ?? 'assets/images/hackathon.jpg');
  }

  @override
  void dispose() {
    _title.dispose();
    _category.dispose();
    _date.dispose();
    _location.dispose();
    _image.dispose();
    super.dispose();
  }

  void _save() {
    final provider = Provider.of<EventProvider>(context, listen: false);
    final id =
        widget.event?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final event = EventModel(
      id: id,
      title: _title.text,
      date: DateTime.tryParse(_date.text) ?? DateTime.now(),
      location: _location.text,
      coordinator: '',
      category: _category.text,
      description: '',
      venue: _location.text,
      imageUrl: _image.text,
      isFeatured: false,
      imagePath:
          'assets/images/default.png', // Added missing 'imagePath' argument
    );

    if (widget.event == null) {
      provider.addEvent(event);
    } else {
      provider.editEvent(event);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.event == null ? 'Add Event' : 'Edit Event')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: _category,
                decoration: const InputDecoration(labelText: 'Category')),
            TextField(
                controller: _date,
                decoration: const InputDecoration(labelText: 'Date (ISO)')),
            TextField(
                controller: _location,
                decoration: const InputDecoration(labelText: 'Location')),
            TextField(
                controller: _image,
                decoration: const InputDecoration(labelText: 'Image path')),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
