import 'package:flutter/material.dart';

import 'package:iet_event_tracker/data/mock_database.dart';
import 'package:iet_event_tracker/models/event_model.dart';

/// EventProvider: provides EventModel lists (compatibility with existing screens)
class EventProvider extends ChangeNotifier {
  final List<EventModel> _events = mockEvents
      .map((e) => EventModel(
            id: e.id,
            title: e.title,
            date: e.dateTime,
            location: e.location,
            coordinator: e.coordinatorName,
            category: e.category,
            description: e.longDescription,
            venue: e.location,
            imageUrl: e.imagePath,
            isFeatured: e.isFeatured,
            imagePath: e.imagePath, // Added missing 'imagePath' argument
          ))
      .toList();

  List<EventModel> get events => List.unmodifiable(_events);

  List<EventModel> get featuredEvents {
    final featured = _events.where((e) => e.isFeatured).toList();
    featured.sort((a, b) => b.date.compareTo(a.date));
    return featured.take(10).toList();
  }

  List<EventModel> get upcomingEvents {
    final upcoming =
        _events.where((e) => e.date.isAfter(DateTime.now())).toList();
    upcoming.sort((a, b) => a.date.compareTo(b.date));
    return upcoming;
  }

  List<EventModel> searchEvents(String query) {
    final q = query.toLowerCase();
    return _events
        .where((e) =>
            e.title.toLowerCase().contains(q) ||
            (e.category ?? '').toLowerCase().contains(q))
        .toList();
  }

  List<EventModel> filterByCategory(String category) {
    if (category == 'All') return events;
    return _events
        .where(
            (e) => (e.category ?? '').toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Admin CRUD using EventModel for compatibility with existing screens
  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }

  void editEvent(EventModel updated) {
    final idx = _events.indexWhere((e) => e.id == updated.id);
    if (idx != -1) {
      _events[idx] = updated;
      notifyListeners();
    }
  }

  void deleteEvent(String id) {
    _events.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
