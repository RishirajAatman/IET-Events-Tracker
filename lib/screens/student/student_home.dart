import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final featuredEvents = eventProvider.featuredEvents;
    final upcomingEvents = eventProvider.upcomingEvents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('IET Events'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome! Discover upcoming events…',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(autoPlay: true, height: 200),
            items: featuredEvents.map((event) {
              return Builder(
                builder: (context) => Card(
                  child: Column(
                    children: [
                      Image.asset(event.imageUrl, fit: BoxFit.cover),
                      Text(event.title),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Upcoming Events',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: upcomingEvents.length,
              itemBuilder: (context, index) {
                final event = upcomingEvents[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.date.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
