import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/common_appbar.dart';
import '../services/firestore_service.dart';

class AddEditEventScreen extends StatefulWidget {
  final EventModel? event;
  const AddEditEventScreen({super.key, this.event});

  @override
  State<AddEditEventScreen> createState() => _AddEditEventScreenState();
}

class _AddEditEventScreenState extends State<AddEditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _image; // Updated to nullable type
  String? _description;
  String? _venue;
  String? _coordinator;
  String? _category;
  String? _registrationLink;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _title = widget.event!.title;
      _image = widget.event!.image;
      _description = widget.event!.description;
      _venue = widget.event!.location;
      _coordinator = widget.event!.coordinator;
      _category = widget.event!.category;
      _registrationLink = widget.event!.registrationLink;
      _date = widget.event!.date;
    } else {
      _title = null;
      _image = null; // Explicitly set to null for new events
      _description = null;
      _venue = null;
      _coordinator = null;
      _category = null;
      _registrationLink = null;
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // normalize image path to full asset path if user provided a filename
      String img = _image ?? '';
      if (img.isNotEmpty && !img.startsWith('assets/')) {
        img = 'assets/images/$img';
      }

      // Replace mock save logic with Firestore
      final eventData = {
        'title': _title,
        'description': _description,
        'date': _date.toIso8601String(),
        'location': _venue,
        'coordinator': _coordinator,
        'category': _category,
        'registrationLink': _registrationLink,
      };
      if (widget.event == null) {
        FirestoreService().addEvent(eventData);
      } else {
        FirestoreService().updateEvent(widget.event!.id, eventData);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppHeader(title: widget.event == null ? 'Add Event' : 'Edit Event'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: "Title"),
                onSaved: (v) => _title = v!,
                validator: (v) => v!.isEmpty ? "Enter title" : null,
              ),
              TextFormField(
                initialValue: _image,
                decoration: const InputDecoration(
                    labelText: "Image name (e.g., hackathon.jpg)"),
                onSaved: (v) => _image = v!,
                validator: (v) => v!.isEmpty ? "Enter image name" : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _venue,
                decoration: const InputDecoration(labelText: "Venue"),
                onSaved: (v) => _venue = v!,
              ),
              TextFormField(
                initialValue: _coordinator,
                decoration: const InputDecoration(labelText: "Coordinator"),
                onSaved: (v) => _coordinator = v!,
              ),
              TextFormField(
                initialValue: _category,
                decoration: const InputDecoration(labelText: "Category"),
                onSaved: (v) => _category = v!,
              ),
              TextFormField(
                initialValue: _registrationLink,
                decoration:
                    const InputDecoration(labelText: "Registration Link"),
                onSaved: (v) => _registrationLink = v!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: "Description"),
                onSaved: (v) => _description = v!,
                validator: (v) => v!.isEmpty ? "Enter description" : null,
              ),
              const SizedBox(height: 10),
              Text("Date: ${_date.toLocal()}".split(' ')[0]),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => _date = picked);
                  }
                },
                child: const Text("Pick Date"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
