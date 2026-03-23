// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:iet_event_tracker/main.dart';
import 'package:iet_event_tracker/providers/event_provider.dart';

class MockFirebaseApp {
  // Removed inheritance issues by making it a standalone mock class
  Future<void> delete() async {}

  Future<void> setAutomaticDataCollectionEnabled(bool enabled) async {}

  Future<void> setAutomaticResourceManagementEnabled(bool enabled) async {}

  bool get isAutomaticDataCollectionEnabled => true;

  bool get isAutomaticResourceManagementEnabled => true;

  String get name => 'mock';

  FirebaseOptions get options => const FirebaseOptions(
        apiKey: 'mock',
        appId: 'mock',
        messagingSenderId: 'mock',
        projectId: 'mock',
      );
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build the app and ensure the login screen is present.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EventProvider()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify the app title is visible on the login screen.
    expect(find.text('IET Event Manager'), findsOneWidget);
  });
}
