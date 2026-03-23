class EventModel {
  /// Unique identifier for the event. Not required for existing code but
  /// helpful for distinguishing events in lists and for CRUD operations.
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final String? location;
  final String? coordinator;
  final String? category;
  final String? registrationLink;
  final String? image;
  final String? venue;
  final String imageUrl;
  final bool isFeatured;
  final String imagePath; // <-- Added imagePath property

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    this.image,
    this.venue,
    this.category,
    this.registrationLink,
    this.coordinator,
    this.description,
    this.location,
    required this.imageUrl,
    required this.isFeatured,
    required this.imagePath, // <-- Required named parameter
  });

  factory EventModel.fromMap(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: DateTime.parse(data['date'] ?? DateTime.now().toIso8601String()),
      location: data['location'],
      coordinator: data['coordinator'],
      category: data['category'],
      registrationLink: data['registrationLink'],
      image: data['image'],
      venue: data['venue'],
      imageUrl: data['imageUrl'] ?? data['image'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      imagePath: data['imagePath'] ??
          data['image'] ??
          '', // Map both imagePath and image fields
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'coordinator': coordinator,
      'category': category,
      'registrationLink': registrationLink,
      'imageUrl': imageUrl,
      'isFeatured': isFeatured,
      'imagePath': imagePath, // <-- Include imagePath in the map
    };
  }
}
