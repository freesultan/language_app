import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Progress',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.grey[200],
              child: const Center(
                child: Text('Progress Details Here'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Achievements',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 100,
              color: Colors.grey[200],
              child: const Center(
                child: Text('Achievement Details Here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
