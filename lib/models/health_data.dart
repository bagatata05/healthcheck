class HealthData {
  final String id;
  final DateTime dateTime;
  final int heartRate;
  final int systolic;
  final int diastolic;
  final String symptoms;

  HealthData({
    required this.id,
    required this.dateTime,
    required this.heartRate,
    required this.systolic,
    required this.diastolic,
    required this.symptoms,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'heartRate': heartRate,
      'systolic': systolic,
      'diastolic': diastolic,
      'symptoms': symptoms,
    };
  }

  factory HealthData.fromMap(Map<String, dynamic> map) {
    return HealthData(
      id: map['id'],
      dateTime: DateTime.parse(map['dateTime']),
      heartRate: map['heartRate'],
      systolic: map['systolic'],
      diastolic: map['diastolic'],
      symptoms: map['symptoms'],
    );
  }
}