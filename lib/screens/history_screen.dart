import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_data_provider.dart';
import '../widgets/custom_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: const Color(0xFF00A99D),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
      ),
      body: Consumer<HealthDataProvider>(
        builder: (context, provider, child) {
          final healthDataList = provider.healthDataList;
          
          if (healthDataList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 80,
                    color: Color(0xFFB2DFDB),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No history available',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start tracking your vital signs',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: healthDataList.length,
            itemBuilder: (context, index) {
              final healthData = healthDataList[index];
              return CustomCard(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF00A99D).withValues(alpha: 0.1),
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFFE53935),
                    ),
                  ),
                  title: Text(
                    provider.formatDate(healthData.dateTime),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    provider.formatTime(healthData.dateTime),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Heart Rate',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                    Text(
                                      '${healthData.heartRate} bpm',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE53935),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Blood Pressure',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                    Text(
                                      '${healthData.systolic}/${healthData.diastolic} mmHg',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF00695C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (healthData.symptoms.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Symptoms',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              healthData.symptoms,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showDeleteConfirmation(context, healthData.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color(0xFFE53935),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this entry?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<HealthDataProvider>(context, listen: false)
                  .deleteHealthData(id);
              Navigator.of(ctx).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}