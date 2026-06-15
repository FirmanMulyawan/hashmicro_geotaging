import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/core/model/model_response/user_response.dart';

class AppPreference {
  static SharedPreferences? _prefs;

  final String _selectedLanguage = 'selected_language';
  final String _isMute = 'isMute';
  final String _userData = 'user_data';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool? isMute() {
    return _prefs?.getBool(_isMute);
  }

  String? getLanguage() {
    return _prefs?.getString(_selectedLanguage);
  }

  Future<void> saveUserData({UserResponse? userData}) async {
    if (userData?.id != null) {
      String jsonData = jsonEncode(userData?.toJson());
      await _prefs?.setString(_userData, jsonData);
    }
  }

  UserResponse? getUserData() {
    String? userData = _prefs?.getString(_userData);
    if (userData != null) {
      try {
        Map<String, dynamic> userDataMap = jsonDecode(userData);
        return UserResponse.fromJson(userDataMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
