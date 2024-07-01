import 'package:flutter/material.dart';

class ProgressTrackerWidget extends StatelessWidget {
  const ProgressTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Tracker',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        LinearProgressIndicator(value: 0.5),
      ],
    );
  }
}
