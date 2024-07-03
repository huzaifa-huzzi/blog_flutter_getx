import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
    await _loadBlogsFromPrefs();
    if (_userId != null) {
      List<Map<String, dynamic>> fetchedBlogs = await _fetchBlogsForUser(_userId!);
      if (fetchedBlogs.isNotEmpty) {
        _blogs = fetchedBlogs;
        await _saveBlogsToPrefs(_blogs);
      }
    }
  }

  Future<List<Map<String, dynamic>>> _fetchBlogsForUser(String userId) async {
    try {
      DataSnapshot snapshot = await _database.child('userBlogs/$userId').get();

      if (!snapshot.exists) {
        print('No blogs found for user $userId');
        return [];
      }

      List<Map<String, dynamic>> fetchedBlogs = [];

      if (snapshot.value is Map) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          fetchedBlogs.add({
            'id': key,
            'title': value['title'],
            'content': value['content'],
            'imageUrl': value['imageUrl'],
            'timestamp': value['timestamp'],
          });
        });
      } else {
        print('Fetched data is not in the expected format.');
      }

      print('Fetched blogs for user $userId: $fetchedBlogs');
      return fetchedBlogs;
    } catch (e) {
      print('Error fetching blogs for user $userId: $e');
      return [];
    }
  }

  Future<void> _saveUserIdToPrefs(String? userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? '');
  }

  Future<void> _saveBlogsToPrefs(List<Map<String, dynamic>> blogs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String blogsJson = jsonEncode(blogs);
    await prefs.setString('blogs', blogsJson);
  }

  Future<void> _loadBlogsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String blogsJson = prefs.getString('blogs') ?? '';
    if (blogsJson.isNotEmpty) {
      _blogs = (jsonDecode(blogsJson) as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
  }

  Future<void> clearUser() async {
    _userId = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('blogs');
  }
}