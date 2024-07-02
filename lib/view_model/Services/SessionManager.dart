
import 'package:get/get.dart';

class SessionManager extends GetxController {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  String? _userId;

  String? get userId => _userId;

  set userId(String? userId) {
    _userId = userId;
    update(); // Notify listeners of the change
  }

  void clear() {
    _userId = null;
    update(); // Notify listeners of the change
  }
}
