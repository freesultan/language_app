import 'package:flutter/material.dart';
import '../../../core/models/lesson.dart';

class DailyLessonWidget extends StatelessWidget {
   

  final Lesson lesson;
  const DailyLessonWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          lesson.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 100,
          color: Colors.grey[200],
          child:  Center(
            child: Text(lesson.content),
          ),
        ),
      ],
    );
  }
}
