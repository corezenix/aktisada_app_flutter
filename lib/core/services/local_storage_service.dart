import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/user_model.dart';
import '../utils/logger.dart' as logger;

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  LocalStorageService._();

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // Token management
  Future<void> saveToken(String token) async {
    if (_preferences == null) return;
    await _preferences!.setString(_tokenKey, token);
  }

  String? getToken() {
    if (_preferences == null) return null;
    return _preferences!.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    if (_preferences == null) return;
    await _preferences!.remove(_tokenKey);
  }

  // User ID management
  Future<void> saveUserId(int userId) async {
    if (_preferences == null) return;
    log('💾 Saving User ID to local storage: $userId');
    await _preferences!.setInt(_userIdKey, userId);
    log('✅ User ID saved successfully');
  }

  int? getUserId() {
    if (_preferences == null) return null;
    final userId = _preferences!.getInt(_userIdKey);
    log('🔍 Retrieved User ID from local storage: $userId');
    return userId;
  }

  Future<void> removeUserId() async {
    if (_preferences == null) return;
    await _preferences!.remove(_userIdKey);
  }

  // User data management
  Future<void> saveUserData(UserModel user) async {
    if (_preferences == null) return;
    final userJson = jsonEncode(user.toJson());
    await _preferences!.setString(_userDataKey, userJson);
  }

  UserModel? getUserData() {
    if (_preferences == null) return null;
    final userJson = _preferences!.getString(_userDataKey);
    if (userJson != null) {
      try {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      } catch (e) {
        logger.logInfo('Error parsing user data: $e');
        return null;
      }
    }
    return null;
  }

  Future<void> removeUserData() async {
    if (_preferences == null) return;
    await _preferences!.remove(_userDataKey);
  }

  // Login state management
  Future<void> setLoggedIn(bool isLoggedIn) async {
    if (_preferences == null) return;
    await _preferences!.setBool(_isLoggedInKey, isLoggedIn);
  }

  bool isLoggedIn() {
    if (_preferences == null) return false;
    return _preferences!.getBool(_isLoggedInKey) ?? false;
  }

  // Clear all data (logout)
  Future<void> clearAll() async {
    if (_preferences == null) return;
    await _preferences!.clear();
  }

  // Save complete auth data
  Future<void> saveAuthData(String token, int userId, UserModel user) async {
    await saveToken(token);
    await saveUserId(userId);
    await saveUserData(user);
    await setLoggedIn(true);
  }

  // Check if user has valid auth data
  bool hasValidAuthData() {
    if (_preferences == null) return false;
    final token = getToken();
    final userId = getUserId();
    final userData = getUserData();
    return token != null &&
        token.isNotEmpty &&
        userId != null &&
        userData != null;
  }

  // Check if service is ready
  bool get isReady => _preferences != null;
}
