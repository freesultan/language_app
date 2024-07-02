import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonProvider with ChangeNotifier {
  final List<Lesson> _lessons = [
    Lesson(title: 'Lesson 1: Introduction', content: 'Introduction Introduction Introduction'),
    Lesson(title: 'Lesson 2: May he bless you', content: 'May he bless you May he bless you'),
    Lesson(title: 'Lesson 3: How to speak English', content: 'How to speak English'),
    // Add more lessons here
  ];

  int _lessonsCompleted = 0;

  List<Lesson> get lessons => _lessons;
  int get lessonsCompleted => _lessonsCompleted;

  
 void completeLesson() {
    _lessonsCompleted++;
    notifyListeners();
  }

  void addLesson(Lesson lesson) {
    _lessons.add(lesson);
    notifyListeners();
  }
}
