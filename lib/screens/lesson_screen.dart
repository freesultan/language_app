import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/lesson_providor.dart';

class LessonScreen extends StatelessWidget {

  final int lessonIndex;
  const LessonScreen({super.key, required this.lessonIndex});

  @override
  Widget build(BuildContext context) {
     var lessonProvider = Provider.of<LessonProvider>(context);
    var lesson = lessonProvider.lessons[lessonIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              lesson.content,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.grey[200],
              child: const Center(
                child: Text('Interactive Exercise Here'),
              ),
            ),
            const Spacer(),
            ElevatedButton(
             
              onPressed: lessonIndex < lessonProvider.lessons.length - 1
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonScreen(
                            lessonIndex: lessonIndex + 1,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Next Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}
