import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonProvider with ChangeNotifier {
  final List<Lesson> _lessons = [
    Lesson(title: 'Lesson 1', content: 'Content for lesson 1'),
    Lesson(title: 'Lesson 2', content: 'Content for lesson 2'),
    // Add more lessons here
  ];

  List<Lesson> get lessons => _lessons;

  void addLesson(Lesson lesson) {
    _lessons.add(lesson);
    notifyListeners();
  }
}
