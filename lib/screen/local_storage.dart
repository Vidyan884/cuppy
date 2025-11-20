import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUser({
    required int id,
    required String email,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
    await prefs.setString('user_email', email);
    await prefs.setString('user_name', name);
  }

  static Future<Map<String, dynamic>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getInt('user_id'),
      'email': prefs.getString('user_email'),
      'name': prefs.getString('user_name'),
    };
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
