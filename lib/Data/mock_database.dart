import '../models/event.dart';
import '../models/user_model.dart';

// Mock database: 20 professional events using assets/images/*
final List<Event> mockEvents = [
  Event(
    id: 'ev001',
    title: 'IET Hackathon 2026',
    category: 'Technical',
    dateTime: DateTime(2026, 2, 14, 9, 0),
    location: 'IET Auditorium',
    coordinatorName: 'Dr. A. Sharma',
    shortDescription:
        '24-hour team coding competition to build innovative solutions.',
    longDescription:
        'Participants will form teams to design, build and present working prototypes. Mentors and prizes available.',
    imagePath: 'assets/images/hackathon.jpg',
    isFeatured: true,
  ),
  Event(
    id: 'ev002',
    title: 'Flutter Workshop',
    category: 'Workshop',
    dateTime: DateTime(2026, 3, 2, 10, 0),
    location: 'Lab 3',
    coordinatorName: 'Ms. Priya K',
    shortDescription:
        'Hands-on Flutter bootcamp for beginners and intermediate developers.',
    longDescription:
        'Learn to build responsive apps, state management, and deploy to Android/iOS. Bring your laptop.',
    imagePath: 'assets/images/flutter.jpg',
    isFeatured: true,
  ),
  Event(
    id: 'ev003',
    title: 'AI & ML Seminar',
    category: 'Technical',
    dateTime: DateTime(2026, 4, 5, 14, 0),
    location: 'Main Lecture Hall',
    coordinatorName: 'Prof. R. Gupta',
    shortDescription:
        'Expert talks on recent advances in AI and machine learning.',
    longDescription:
        'A panel of industry leaders will discuss trends, careers, and research opportunities in AI.',
    imagePath: 'assets/images/aiml.jpg',
    isFeatured: true,
  ),
  Event(
    id: 'ev004',
    title: 'Robotics Workshop',
    category: 'Workshop',
    dateTime: DateTime(2026, 1, 28, 9, 30),
    location: 'Robotics Lab',
    coordinatorName: 'Eng. S. Rao',
    shortDescription: 'Build and program a line-following robot in one day.',
    longDescription:
        'Teams will get components and mentorship to assemble functional robots and compete.',
    imagePath: 'assets/images/robotics.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev005',
    title: 'Cultural Night 2026',
    category: 'Cultural',
    dateTime: DateTime(2026, 2, 20, 18, 0),
    location: 'Open Auditorium',
    coordinatorName: 'Ms. Neha Singh',
    shortDescription:
        'An evening of music, dance and theatre by student clubs.',
    longDescription:
        'Join the community for performances, food stalls and student showcases. Family welcome.',
    imagePath: 'assets/images/cultural.jpg',
    isFeatured: true,
  ),
  Event(
    id: 'ev006',
    title: 'Intercollege Sports Day',
    category: 'Sports',
    dateTime: DateTime(2026, 3, 25, 8, 0),
    location: 'Main Ground',
    coordinatorName: 'Mr. K. Varma',
    shortDescription:
        'Track and field events with teams from across the region.',
    longDescription:
        'Register for athletics, football, basketball and more. Medals for winners and refreshments.',
    imagePath: 'assets/images/dance.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev007',
    title: 'Design Sprint',
    category: 'Workshop',
    dateTime: DateTime(2026, 4, 12, 9, 0),
    location: 'Design Studio',
    coordinatorName: 'Ms. L. Fernandes',
    shortDescription:
        'Hands-on UX design sprint to prototype a user-centric product.',
    longDescription:
        'Facilitators guide teams through user research, ideation, and rapid prototyping.',
    imagePath: 'assets/images/startup.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev008',
    title: 'Entrepreneurship Talk',
    category: 'Technical',
    dateTime: DateTime(2026, 5, 3, 16, 0),
    location: 'Conference Room',
    coordinatorName: 'Mr. D. Mehta',
    shortDescription:
        'Founders share their startup journeys and fundraising tips.',
    longDescription:
        'A Q&A session with entrepreneurs from technology and social impact sectors.',
    imagePath: 'assets/images/startup.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev009',
    title: 'Cybersecurity Bootcamp',
    category: 'Workshop',
    dateTime: DateTime(2026, 1, 18, 10, 0),
    location: 'Lab 1',
    coordinatorName: 'Dr. M. Iyer',
    shortDescription:
        'Practical hands-on cyber range and vulnerability assessment.',
    longDescription:
        'Learn networking security, common vulnerabilities and remediation techniques.',
    imagePath: 'assets/images/cyber.jpg',
    isFeatured: true,
  ),
  Event(
    id: 'ev010',
    title: 'Photography Competition',
    category: 'Cultural',
    dateTime: DateTime(2026, 2, 6, 11, 0),
    location: 'Art Block',
    coordinatorName: 'Ms. R. Das',
    shortDescription: 'Capture campus life — prizes for best compositions.',
    longDescription:
        'Submit photos in categories: Portrait, Landscape and Street. Exhibition to follow.',
    imagePath: 'assets/images/photography.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev011',
    title: 'Coding Competition',
    category: 'Technical',
    dateTime: DateTime(2026, 3, 10, 13, 0),
    location: 'Computer Lab',
    coordinatorName: 'Mr. V. Nair',
    shortDescription: 'Algorithmic coding contest for all levels.',
    longDescription:
        'Individual and team rounds with progressive problems — judge panel from industry.',
    imagePath: 'assets/images/hackathon.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev012',
    title: 'Alumni Networking Evening',
    category: 'Networking',
    dateTime: DateTime(2026, 4, 20, 18, 30),
    location: 'Alumni Hall',
    coordinatorName: 'Alumni Office',
    shortDescription:
        'Meet alumni, build connections, and explore mentorships.',
    longDescription:
        'Open mixer for current students and alumni with talks and mentorship signups.',
    imagePath: 'assets/images/cultural.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev013',
    title: 'Music Fest',
    category: 'Cultural',
    dateTime: DateTime(2026, 5, 15, 19, 0),
    location: 'Open Grounds',
    coordinatorName: 'Music Club',
    shortDescription: 'Live bands and solo acts showcasing campus talent.',
    longDescription:
        'An evening festival with food stalls, art stalls and live performances.',
    imagePath: 'assets/images/singing.jpg',
    isFeatured: true,
  ),
  Event(
    id: 'ev014',
    title: 'Math Quiz',
    category: 'Academic',
    dateTime: DateTime(2026, 2, 11, 15, 0),
    location: 'Seminar Hall',
    coordinatorName: 'Dr. S. Patel',
    shortDescription: 'Inter-department math challenge with knockout rounds.',
    longDescription:
        'Teams compete on logic, proofs and applied mathematics problems with prizes.',
    imagePath: 'assets/images/aiml.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev015',
    title: 'Debate Championship',
    category: 'Cultural',
    dateTime: DateTime(2026, 3, 1, 17, 0),
    location: 'Debate Hall',
    coordinatorName: 'Speech Club',
    shortDescription:
        'Oxford-style debates on current affairs and technology ethics.',
    longDescription:
        'Teams will prepare motions and face adjudicators from external colleges.',
    imagePath: 'assets/images/cultural.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev016',
    title: 'Art Exhibition',
    category: 'Cultural',
    dateTime: DateTime(2026, 4, 2, 10, 0),
    location: 'Art Gallery',
    coordinatorName: 'Art Society',
    shortDescription: 'Student artworks and installations on display.',
    longDescription:
        'A curated exhibition of paintings, installations and digital art by students.',
    imagePath: 'assets/images/photography.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev017',
    title: 'Cloud Bootcamp',
    category: 'Technical',
    dateTime: DateTime(2026, 1, 30, 9, 0),
    location: 'Lab 2',
    coordinatorName: 'Cloud Club',
    shortDescription: 'AWS/GCP hands-on labs and certification guidance.',
    longDescription:
        'Guided labs, real-world scenarios and pathways to certifications for attendees.',
    imagePath: 'assets/images/cyber.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev018',
    title: 'Yoga & Wellness Session',
    category: 'Wellness',
    dateTime: DateTime(2026, 2, 3, 7, 0),
    location: 'Gym Hall',
    coordinatorName: 'Wellness Club',
    shortDescription: 'Start your day with guided yoga and mindfulness.',
    longDescription:
        'Open to everyone. Basic yoga instructions, breathing exercises and stress relief tips.',
    imagePath: 'assets/images/dance.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev019',
    title: 'Food Fair',
    category: 'Cultural',
    dateTime: DateTime(2026, 3, 8, 12, 0),
    location: 'Cafeteria Lawn',
    coordinatorName: 'Cultural Council',
    shortDescription:
        'A celebration of flavours with stalls from students and local vendors.',
    longDescription:
        'Taste a variety of cuisines, vote for your favourite stall and enjoy live music.',
    imagePath: 'assets/images/cultural.jpg',
    isFeatured: false,
  ),
  Event(
    id: 'ev020',
    title: 'Startup Pitch Day',
    category: 'Technical',
    dateTime: DateTime(2026, 5, 28, 11, 0),
    location: 'Innovation Hub',
    coordinatorName: 'Incubation Cell',
    shortDescription: 'Student startups pitch to mentors and angel investors.',
    longDescription:
        'Selected teams present 5-minute pitches followed by feedback and follow-on mentorship.',
    imagePath: 'assets/images/startup.jpg',
    isFeatured: true,
  ),
];

/// Minimal MockDatabase for legacy screens that expect local users.
class MockDatabase {
  static final List<UserModel> users = [
    UserModel(
      id: 'admin',
      name: 'Admin User',
      email: 'admin@eventify.com',
      password: 'admin123',
      role: 'admin',
    ),
    UserModel(
      id: 'student',
      name: 'Student User',
      email: 'student@eventify.com',
      password: 'student123',
      role: 'student',
    ),
  ];
}
