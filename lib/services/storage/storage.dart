import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future _getStorageInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // * Setters
  static Future<bool> setBool({
    required String key,
    required bool value,
  }) async {
    await _getStorageInstance();
    if ((await _prefs?.setBool(key, value)) ?? false) {
      return true;
    }
    return false;
  }

  static Future<bool> setString({
    required String key,
    required String value,
  }) async {
    await _getStorageInstance();
    if ((await _prefs?.setString(key, value)) ?? false) {
      return true;
    }
    return false;
  }

  static Future<bool> setListString({
    required String key,
    required List<String> value,
  }) async {
    await _getStorageInstance();
    if ((await _prefs?.setStringList(key, value)) ?? false) {
      return true;
    }
    return false;
  }
  
  // * Getters
  static  Future<String?> getString({
    required String key,
  }) async {
    await _getStorageInstance();
    return _prefs?.getString(key);
  }

  static Future<bool?> getBool({
    required String key,
  }) async {
    await _getStorageInstance();
    return _prefs?.getBool(key);
  }

  static  Future<List<String>?> getListString({
    required String key,
  }) async {
    await _getStorageInstance();
    return _prefs?.getStringList(key);
  }

  // * Removing
  static Future<bool> remove({
    required String key,
  }) async {
    await _getStorageInstance();
    if ((await _prefs?.remove(key)) ?? false) {
      return true;
    }
    return false;
  }
}