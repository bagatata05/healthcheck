import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/health_data.dart';
import '../services/storage_service.dart';

class HealthDataProvider with ChangeNotifier {
  List<HealthData> _healthDataList = [];

  List<HealthData> get healthDataList => _healthDataList;

  HealthData? get latestData => _healthDataList.isNotEmpty ? _healthDataList.first : null;

  int get averageHeartRate {
    if (_healthDataList.isEmpty) return 0;
    final sum = _healthDataList.fold<int>(0, (sum, item) => sum + item.heartRate);
    return (sum / _healthDataList.length).round();
  }

  int get averageSystolic {
    if (_healthDataList.isEmpty) return 0;
    final sum = _healthDataList.fold<int>(0, (sum, item) => sum + item.systolic);
    return (sum / _healthDataList.length).round();
  }

  int get averageDiastolic {
    if (_healthDataList.isEmpty) return 0;
    final sum = _healthDataList.fold<int>(0, (sum, item) => sum + item.diastolic);
    return (sum / _healthDataList.length).round();
  }

  Future<void> addHealthData(HealthData healthData) async {
    _healthDataList.insert(0, healthData);
    await StorageService.saveHealthData(_healthDataList);
    notifyListeners();
  }

  Future<void> deleteHealthData(String id) async {
    _healthDataList.removeWhere((item) => item.id == id);
    await StorageService.saveHealthData(_healthDataList);
    notifyListeners();
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  int calculateHealthScore() {
    if (_healthDataList.isEmpty) return 75; // Default score
    
    final latest = _healthDataList.first;
    int score = 100;
    
    // Heart rate scoring
    if (latest.heartRate < 60 || latest.heartRate > 100) {
      score -= 20;
    } else if (latest.heartRate < 70 || latest.heartRate > 90) {
      score -= 10;
    }
    
    // Blood pressure scoring
    if (latest.systolic > 140 || latest.diastolic > 90) {
      score -= 20;
    } else if (latest.systolic > 130 || latest.diastolic > 85) {
      score -= 10;
    }
    
    return score.clamp(0, 100);
  }

  int getDaysTracked() {
    if (_healthDataList.isEmpty) return 0;
    
    final uniqueDays = _healthDataList
        .map((data) => DateTime(data.dateTime.year, data.dateTime.month, data.dateTime.day))
        .toSet();
    
    return uniqueDays.length;
  }

  // Load data from storage
  Future<void> loadData() async {
    _healthDataList = await StorageService.loadHealthData();
    notifyListeners();
  }

  // Clear all data
  Future<void> clearAllData() async {
    _healthDataList.clear();
    await StorageService.clearHealthData();
    notifyListeners();
  }

  // Reset to fresh install state
  Future<void> resetToFreshInstall() async {
    await StorageService.resetAllData();
    _healthDataList.clear();
    notifyListeners();
  }
}