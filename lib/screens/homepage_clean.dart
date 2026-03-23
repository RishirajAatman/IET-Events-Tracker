import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import '../widgets/common_appbar.dart'; // no longer used
import '../models/event_model.dart';
import '../widgets/asset_placeholder.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import 'event_detail_screen.dart';

class HomepageClean extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  const HomepageClean({super.key, this.userName, this.userEmail});

  @override
  State<HomepageClean> createState() => _HomepageCleanState();
}

class _HomepageCleanState extends State<HomepageClean>
    with SingleTickerProviderStateMixin {
  late final AnimationController _introController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  final PageController _pageController = PageController(viewportFraction: 0.92);
  Timer? _carouselTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _introController, curve: Curves.easeOut));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _introController, curve: Curves.easeIn));
    _introController.forward();
    // No local event loading; events come from Provider
  }

  void _startAutoPlay(int eventCount) {
    _carouselTimer?.cancel();
    if (eventCount == 0) return;
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_pageControllerHasClients()) {
        _currentPage = (_currentPage + 1) % eventCount;
        if (mounted) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  bool _pageControllerHasClients() {
    try {
      return _pageController.hasClients;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _introController.dispose();
    _pageController.dispose();
    _carouselTimer?.cancel();
    super.dispose();
  }

  Widget _buildIntro() {
    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Welcome${widget.userName != null ? ', ${widget.userName}' : ''}!',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Discover upcoming events and join the campus buzz.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(List<EventModel> events) {
    if (events.isEmpty) return const SizedBox.shrink();
    return CarouselSlider.builder(
      itemCount: events.length,
      itemBuilder: (context, index, realIdx) {
        final e = events[index];
        return GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => EventDetailScreen(event: e))),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                color: Colors.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  assetImageOrPlaceholder(e.image ?? '', // Ensure null safety
                      fit: BoxFit.cover,
                      title: e.title),
                  const DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [Colors.black54, Colors.transparent]))),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    right: 12,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat.yMMMd().format(e.date),
                                    style:
                                        const TextStyle(color: Colors.white70)),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            103, 58, 183, 0.9),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(e.category ?? 'Uncategorized',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                              ])
                        ]),
                  )
                ],
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        enableInfiniteScroll: true,
        onPageChanged: (idx, reason) => setState(() => _currentPage = idx),
      ),
    );
  }

  Widget _buildIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _currentPage == i ? 14 : 8,
            height: 8,
            decoration: BoxDecoration(
                color: _currentPage == i
                    ? Colors.deepPurple
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)));
      }),
    );
  }

  Widget _buildUpcomingList(List<EventModel> events) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10),
      const Text('Upcoming Events',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ...events.map((e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EventDetailScreen(event: e)),
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: assetImageOrPlaceholder(e.image ?? '',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          title: e.title)),
                  title: Text(e.title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                      '${DateFormat.yMMMd().format(e.date)} • ${e.venue ?? 'Unknown Venue'}'), // Handle nullable venue
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                ),
              ),
            ),
          )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Always use the provider for the event list; this ensures live sync across all screens.
    final events = context.watch<EventProvider>().events;
    final filteredEvents = events
        .where((e) => e.image != null) // Ensure `image` is not null
        .toList();
    // Start/refresh carousel autoplay if event count changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPlay(filteredEvents.length);
    });
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // IET DAVV Logo Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/ietdavvlogo.jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.school,
                            size: 25,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IET DAVV',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Event Manager',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildIntro(),
          const SizedBox(height: 18),
          _buildCarousel(filteredEvents),
          const SizedBox(height: 8),
          _buildIndicator(filteredEvents.length),
          const SizedBox(height: 12),
          _buildUpcomingList(filteredEvents),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
