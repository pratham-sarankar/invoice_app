import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userPhoneKey = 'userPhone';
  static const String _userNameKey = 'userName';

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      print('⚠️ [WARNING] Failed to check login status: $e');
      return false; // Assume not logged in on error
    }
  }

  // Set user as logged in
  static Future<bool> setLoggedIn({
    required String phone,
    required String name,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userPhoneKey, phone);
      await prefs.setString(_userNameKey, name);
      print('✅ [DEBUG] User login state saved successfully');
      return true;
    } catch (e) {
      print('❌ [ERROR] Failed to save login state: $e');
      print('⚠️ [WARNING] Continuing without saving login state...');
      return false; // Return false if saving failed
    }
  }

  // Logout user
  static Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, false);
      await prefs.remove(_userPhoneKey);
      await prefs.remove(_userNameKey);
      print('✅ [DEBUG] User logout successful');
      return true;
    } catch (e) {
      print('❌ [ERROR] Failed to logout: $e');
      return false;
    }
  }

  // Get user phone
  static Future<String?> getUserPhone() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userPhoneKey);
    } catch (e) {
      print('⚠️ [WARNING] Failed to get user phone: $e');
      return null;
    }
  }

  // Get user name
  static Future<String?> getUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userNameKey);
    } catch (e) {
      print('⚠️ [WARNING] Failed to get user name: $e');
      return null;
    }
  }

  // Update user name
  static Future<bool> updateUserName(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userNameKey, name);
      return true;
    } catch (e) {
      print('❌ [ERROR] Failed to update user name: $e');
      return false;
    }
  }

  // Update user phone
  static Future<bool> updateUserPhone(String phone) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userPhoneKey, phone);
      return true;
    } catch (e) {
      print('❌ [ERROR] Failed to update user phone: $e');
      return false;
    }
  }
} 