
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  String? _userId;
  List<Map<String, dynamic>> _blogs = []; // Store blogs here

  String? get userId => _userId;

  set userId(String? userId) {
    _userId = userId;
    _saveUserIdToPrefs(userId); // Save userId to SharedPreferences
  }

  // Initialize SessionManager
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    // Initialize blogs if userId is available
    if (_userId != null) {
      _blogs = await _fetchBlogsForUser(_userId!);
    }
  }

  // Get list of blogs
  List<Map<String, dynamic>> get blogs => _blogs;

  // Method to fetch blogs for a user (replace with your implementation)
  Future<List<Map<String, dynamic>>> _fetchBlogsForUser(String userId) async {
    // Replace this with actual logic to fetch blogs from Firebase or other backend
    return []; // Dummy implementation, replace with actual data fetching
  }

  // Save userId to SharedPreferences
  Future<void> _saveUserIdToPrefs(String? userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? '');
  }


  // Clear user session
  Future<void> clearUser() async {
    _userId = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

// Add methods for updating blogs, profile picture, etc. as needed
}
