import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iet_event_tracker/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _profile;
  bool _loading = true;

  UserProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  UserModel? get currentUserProfile => _profile;
  bool get loading => _loading;

  Future<void> refreshProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _onAuthStateChanged(user);
    }
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _loading = true;
    _profile = null;
    notifyListeners();

    if (user == null) {
      _loading = false;
      notifyListeners();
      return;
    }

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        _profile = UserModel(
          id: user.uid,
          name: data['fullName'] ?? data['name'] ?? '',
          email: user.email ?? '',
          password: '',
          role: data['role'] ?? 'student',
          phone: data['phone'],
          profileImage: data['profileImage'],
        );
      } else {
        // fallback profile built from auth
        _profile = UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          password: '',
          role: 'student',
        );
      }
    } catch (e) {
      _profile = UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        password: '',
        role: 'student',
      );
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
