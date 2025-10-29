import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/user_model.dart';

@lazySingleton
class UserLocalDataSource {
  static const String _userKey = 'cached_user';
  static const String _userIdKey = 'user_id';

  final SharedPreferences _prefs;

  UserLocalDataSource(this._prefs);

  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_userKey, json.encode(user.toJson()));
    await _prefs.setInt(_userIdKey, user.id);
  }

  UserModel? getUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  int? getUserId() {
    return _prefs.getInt(_userIdKey);
  }

  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
    await _prefs.remove(_userIdKey);
  }

  bool hasUser() {
    return _prefs.containsKey(_userKey);
  }
}
