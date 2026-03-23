import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../../screens/event_detail.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _search = '';
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final events = _search.isEmpty
        ? provider.filterByCategory(_filter)
        : provider.searchEvents(_search);

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
            const Text('Explore'),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search events by name',
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'All',
                  'Technical',
                  'Cultural',
                  'Workshop',
                  'Sports',
                  'Wellness'
                ]
                    .map((c) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(c),
                            selected: _filter == c,
                            onSelected: (_) => setState(() => _filter = c),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, i) {
                  final e = events[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(e.imageUrl,
                          width: 60, height: 60, fit: BoxFit.cover),
                      title: Text(e.title),
                      subtitle: Text(
                          '${e.category} • ${e.date.toLocal().toString().split(' ')[0]}'),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EventDetailScreen(event: e))),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
