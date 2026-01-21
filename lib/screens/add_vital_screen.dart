import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/health_data_provider.dart';
import '../models/health_data.dart';
import '../widgets/vital_form_field.dart';

class AddVitalScreen extends StatefulWidget {
  const AddVitalScreen({super.key});

  @override
  State<AddVitalScreen> createState() => _AddVitalScreenState();
}

class _AddVitalScreenState extends State<AddVitalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heartRateController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _symptomsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _heartRateController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveVital() {
    if (_formKey.currentState!.validate()) {
      final dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final healthData = HealthData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dateTime: dateTime,
        heartRate: int.parse(_heartRateController.text),
        systolic: int.parse(_systolicController.text),
        diastolic: int.parse(_diastolicController.text),
        symptoms: _symptomsController.text,
      );

      Provider.of<HealthDataProvider>(context, listen: false)
          .addHealthData(healthData);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vital Entry'),
        backgroundColor: Color(0xFF00A99D),
        foregroundColor: Color(0xFFFFFFFF),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vital Signs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00A99D),
                ),
              ),
              const SizedBox(height: 16),
              
              // Date & Time Selection
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Date',
                            hintText: 'Select date',
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF5F5F5),
                          ),
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(_selectedDate),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Time',
                            hintText: 'Select time',
                            prefixIcon: const Icon(Icons.access_time),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF5F5F5),
                          ),
                          controller: TextEditingController(
                            text: _selectedTime.format(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Heart Rate
              VitalFormField(
                label: 'Heart Rate',
                hintText: 'Enter heart rate in bpm',
                controller: _heartRateController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.favorite),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter heart rate';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  final heartRate = int.parse(value);
                  if (heartRate < 30 || heartRate > 220) {
                    return 'Heart rate should be between 30 and 220';
                  }
                  return null;
                },
              ),
              
              // Blood Pressure
              const SizedBox(height: 8),
              const Text(
                'Blood Pressure',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF666666),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: VitalFormField(
                      label: 'Systolic',
                      hintText: 'Upper value',
                      controller: _systolicController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Invalid number';
                        }
                        final systolic = int.parse(value);
                        if (systolic < 70 || systolic > 250) {
                          return 'Invalid value';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: VitalFormField(
                      label: 'Diastolic',
                      hintText: 'Lower value',
                      controller: _diastolicController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Invalid number';
                        }
                        final diastolic = int.parse(value);
                        if (diastolic < 40 || diastolic > 150) {
                          return 'Invalid value';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              
              // Symptoms
              VitalFormField(
                label: 'Symptoms',
                hintText: 'Describe any symptoms (optional)',
                controller: _symptomsController,
                maxLines: 3,
                prefixIcon: const Icon(Icons.sick),
              ),
              
              const SizedBox(height: 24),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveVital,
                  child: const Text(
                    'Save Vital Entry',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}