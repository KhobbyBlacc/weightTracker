//for storing UserData in the app and retirve it later

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';



class PreferencesServices {
  static late SharedPreferences _preferences;
  static init() async => _preferences = await SharedPreferences.getInstance();

  static Future saveUserPreference(UserModel user) async {
    await _preferences.setString("user", json.encode(user.toJson()));

   
  }

  static getUserPreferences() {
    String? user = _preferences.getString("user");

    if (user == null) return null;
    return UserModel.fromJson(json.decode(user));
  }

  static clearUserPreferences() async {
    await _preferences.clear();
  }
}


