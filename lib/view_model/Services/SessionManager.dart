import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  DatabaseReference _database = FirebaseDatabase.instance.ref();
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  String? _userId;
  List<Map<String, dynamic>> _blogs = [];

  String? get userId => _userId;
  List<Map<String, dynamic>> get blogs => _blogs;

  set userId(String? userId) {
    _userId = userId;
    _saveUserIdToPrefs(userId);
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    if (_userId != null) {
      await _fetchBlogsForUser(_userId!); // Fetch blogs directly from Firebase
    }
  }

  Future<void> _fetchBlogsForUser(String userId) async {
    try {
      DataSnapshot snapshot = await _database.child('ProfilePicture/$userId/blogs').get();

      if (!snapshot.exists) {
        print('No blogs found for user $userId');
        _blogs = [];
        return;
      }

      List<Map<String, dynamic>> fetchedBlogs = [];

      if (snapshot.value is Map) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          fetchedBlogs.add({
            'id': key,
            'text': value['text'],
            'imageUrl': value['imageUrl'],
            'timestamp': value['timestamp'],
          });
        });
      } else {
        print('Fetched data is not in the expected format.');
      }

      _blogs = fetchedBlogs;
      print('Fetched blogs for user $userId: $fetchedBlogs');
    } catch (e) {
      print('Error fetching blogs for user $userId: $e');
      _blogs = [];
    }
  }

  Future<void> _saveUserIdToPrefs(String? userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? '');
  }

  Future<void> clearUser() async {
    _userId = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }
}
