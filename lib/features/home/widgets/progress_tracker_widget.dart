import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/lesson_providor.dart';


class ProgressTrackerWidget extends StatelessWidget {
  const ProgressTrackerWidget({super.key});

 
  @override
  Widget build(BuildContext context) {
    var lessonProvidor = Provider.of<LessonProvider>(context);
    var progress = lessonProvidor.lessonsCompleted / lessonProvidor.lessons.length;

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progress Tracker',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(value: progress),
      ],
    );
  }
}
