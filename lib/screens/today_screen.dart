import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  List<EventModel> todayEvents = [];

  @override
  void initState() {
    super.initState();
    loadTodayEvents();
  }

  Future<void> loadTodayEvents() async {
    final data = await rootBundle.loadString('assets/events.json');
    final jsonList = json.decode(data) as List;
    final events = jsonList
        .map((e) => EventModel.fromMap(e['id'], e))
        .toList(); // Replaced `fromJson` with `fromMap`

    final now = DateTime.now();
    final todayList = events
        .where((event) =>
            event.date.year == now.year &&
            event.date.month == now.month &&
            event.date.day == now.day)
        .toList();

    setState(() {
      todayEvents = todayList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: todayEvents.isEmpty
          ? const Center(child: Text("No events today 🎉"))
          : ListView.builder(
              itemCount: todayEvents.length,
              itemBuilder: (context, index) {
                final ev = todayEvents[index];
                return EventCard(
                  event: ev,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EventDetailScreen(event: ev)),
                  ),
                );
              },
            ),
    );
  }
}
