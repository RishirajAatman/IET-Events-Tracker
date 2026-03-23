import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../widgets/asset_placeholder.dart';

/// ExploreScreen shows categories and a searchable list of events.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _query = '';
  String _selectedCategory = '';
  final List<String> _categories = [
    'Technical',
    'Cultural',
    'Workshop',
    'Business'
  ];

  List<EventModel> _filterEvents(List<EventModel> events) {
    return events.where((e) {
      final matchesQuery = _query.isEmpty ||
          e.title.toLowerCase().contains(
              _query.toLowerCase()); // Removed unnecessary null-aware operator
      final matchesCategory = _selectedCategory.isEmpty ||
          (e.category?.toLowerCase() ?? '') ==
              _selectedCategory.toLowerCase(); // Added null safety
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final events = context.watch<EventProvider>().events;
    final filtered = _filterEvents(events);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/ietdavvlogo.jpeg',
                  fit: BoxFit.contain,
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
            const Text('Explore Events'),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search events',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : '';
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final event = filtered[index];
                return ListTile(
                  leading: assetImageOrPlaceholder(event.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      title: event.title),
                  title: Text(event.title),
                  subtitle: Text(event.date.toLocal().toString().split(' ')[0]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
