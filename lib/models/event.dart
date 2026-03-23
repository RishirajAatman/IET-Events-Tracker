class Event {
  final String id;
  final String title;
  final String category;
  final DateTime dateTime;
  final String location;
  final String coordinatorName;
  final String shortDescription;
  final String longDescription;
  final String imagePath;
  final bool isFeatured;

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.dateTime,
    required this.location,
    required this.coordinatorName,
    required this.shortDescription,
    required this.longDescription,
    required this.imagePath,
    this.isFeatured = false,
  });

  Event copyWith({
    String? id,
    String? title,
    String? category,
    DateTime? dateTime,
    String? location,
    String? coordinatorName,
    String? shortDescription,
    String? longDescription,
    String? imagePath,
    bool? isFeatured,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      coordinatorName: coordinatorName ?? this.coordinatorName,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      imagePath: imagePath ?? this.imagePath,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'coordinatorName': coordinatorName,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'imagePath': imagePath,
      'isFeatured': isFeatured,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
      location: map['location'] as String,
      coordinatorName: map['coordinatorName'] as String,
      shortDescription: map['shortDescription'] as String,
      longDescription: map['longDescription'] as String,
      imagePath: map['imagePath'] as String,
      isFeatured: map['isFeatured'] as bool,
    );
  }

  @override
  String toString() => 'Event($id, $title)';
}
