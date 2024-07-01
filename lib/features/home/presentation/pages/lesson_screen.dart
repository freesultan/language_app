import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lesson Content',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              onPressed: () {
                // Navigate to next lesson or perform action
              },
              child: const Text('Next Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}
