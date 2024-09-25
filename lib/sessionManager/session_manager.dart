import 'package:hive/hive.dart';

class SessionManager {
  static Box getSessionBox() => Hive.box('sessionBox');

  static Future<void> saveUserSession(
      String userId, String userType, String accesstoken) async {
    var box = getSessionBox();
    await box.put('userId', userId);
    await box.put('userType', userType);
    await box.put('accesstoken', accesstoken);
  }

  static String? getUserId() {
    var box = getSessionBox();
    return box.get('userId');
  }

  static String? getUserType() {
    var box = getSessionBox();
    return box.get('userType');
  }

  static String? getUserToken() {
    var box = getSessionBox();
    return box.get('accesstoken');
  }

  static Future<void> clearSession() async {
    var box = getSessionBox();
    await box.clear();
  }
}
