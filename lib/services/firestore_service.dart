import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEvent(Map<String, dynamic> eventData) async {
    try {
      await _firestore.collection('events').add(eventData);
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getEvents() {
    return _firestore.collection('events').snapshots();
  }

  Future<void> updateEvent(
      String eventId, Map<String, dynamic> eventData) async {
    try {
      await _firestore.collection('events').doc(eventId).update(eventData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<DocumentSnapshot> getUser(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }
}
