import 'package:flutter/material.dart';
import '../../widgets/daily_lesson_widget.dart';
import '../../widgets/progress_tracker_widget.dart';
import '../../widgets/bottom_nav_bar.dart'; 
import 'package:provider/provider.dart';
import '../../../../core/services/lesson_providor.dart';
import 'flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
       var lessonProvider = Provider.of<LessonProvider>(context);
       var currentLesson = lessonProvider.lessons.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DailyLessonWidget(lesson: currentLesson),
            const SizedBox(height: 20),
            const ProgressTrackerWidget(),
            const Spacer(),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
