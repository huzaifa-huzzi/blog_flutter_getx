

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final SessionManager _session = SessionManager._internal();

  String? _userId;

  factory SessionManager() {
    return _session;
  }

  SessionManager._internal();

  String? get userId => _userId;

  Future<void> setUserId(String? id) async {
    _userId = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (id != null) {
      await prefs.setString('userId', id);
    } else {
      await prefs.remove('userId');
    }
  }

  Future<void> loadSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
  }
}
