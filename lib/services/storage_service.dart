import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/health_data.dart';

class StorageService {
  static const String _healthDataKey = 'health_data_list';
  static const String _firstRunKey = 'is_first_run';
  static const String _appVersionKey = 'app_version';

  // Save health data list to local storage
  static Future<void> saveHealthData(List<HealthData> healthDataList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> encodedData = healthDataList
          .map((data) => jsonEncode(data.toMap()))
          .toList();
      await prefs.setStringList(_healthDataKey, encodedData);
    } catch (e) {
      debugPrint('Error saving health data: $e');
    }
  }

  // Load health data list from local storage
  static Future<List<HealthData>> loadHealthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? encodedData = prefs.getStringList(_healthDataKey);
      
      if (encodedData == null || encodedData.isEmpty) {
        return [];
      }

      return encodedData
          .map((data) => HealthData.fromMap(jsonDecode(data)))
          .toList();
    } catch (e) {
      debugPrint('Error loading health data: $e');
      return [];
    }
  }

  // Clear all health data
  static Future<void> clearHealthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_healthDataKey);
    } catch (e) {
      debugPrint('Error clearing health data: $e');
    }
  }

  // Check if this is the first run
  static Future<bool> isFirstRun() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_firstRunKey) ?? true;
    } catch (e) {
      debugPrint('Error checking first run: $e');
      return true;
    }
  }

  // Mark first run as completed
  static Future<void> setFirstRunComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_firstRunKey, false);
    } catch (e) {
      debugPrint('Error setting first run complete: $e');
    }
  }

  // Get stored app version
  static Future<String?> getAppVersion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_appVersionKey);
    } catch (e) {
      debugPrint('Error getting app version: $e');
      return null;
    }
  }

  // Set app version
  static Future<void> setAppVersion(String version) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_appVersionKey, version);
    } catch (e) {
      debugPrint('Error setting app version: $e');
    }
  }

  // Reset all data (for fresh install simulation)
  static Future<void> resetAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      debugPrint('Error resetting all data: $e');
    }
  }
}
