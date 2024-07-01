import 'package:flutter/material.dart';

class SpeechExerciseScreen extends StatelessWidget {
  const SpeechExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Speak the following phrase:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: const Center(
                child: Text('Phrase to be spoken'),
              ),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.mic, size: 50),
              onPressed: () {
                // Start recording
              },
            ),
            const SizedBox(height: 20),
            Container(
              height: 100,
              color: Colors.grey[200],
              child: const Center(
                child: Text('Feedback Display Here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
