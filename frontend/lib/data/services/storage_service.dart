import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language_code';
  
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late SharedPreferences _prefs;
  
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }
  
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }
  
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
  
  Future<void> saveUserId(int userId) async {
    await _prefs.setInt(_userIdKey, userId);
  }
  
  int? getUserId() {
    return _prefs.getInt(_userIdKey);
  }
  
  Future<void> saveThemeMode(String mode) async {
    await _prefs.setString(_themeKey, mode);
  }
  
  String? getThemeMode() {
    return _prefs.getString(_themeKey);
  }
  
  Future<void> saveLanguageCode(String code) async {
    await _prefs.setString(_languageKey, code);
  }
  
  String? getLanguageCode() {
    return _prefs.getString(_languageKey);
  }
  
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    await _prefs.clear();
  }
  
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }
  
  String? getString(String key) {
    return _prefs.getString(key);
  }
  
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }
  
  int? getInt(String key) {
    return _prefs.getInt(key);
  }
  
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }
  
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
  
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
