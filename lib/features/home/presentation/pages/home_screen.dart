import 'package:flutter/material.dart';
import '../../widgets/daily_lesson_widget.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/lesson_providor.dart';

import 'package:language_app/core/services/auth_service.dart';
import 'package:language_app/features/home/presentation/pages/login_screen.dart';
import 'package:language_app/features/home/presentation/pages/register_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var lessonProvider = Provider.of<LessonProvider>(context);
    var currentLesson = lessonProvider.lessons.first;

    final authService = Provider.of<AuthService>(context);
    final currentUser = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          if (currentUser != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Hello, ${currentUser.username}')),
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('bg1.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child:  currentUser != null 
           ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DailyLessonWidget(lesson: currentLesson),
            const SizedBox(height: 20),
            const Spacer(),
            const BottomNavBar(),
          ],
        ),
      )
      : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Please log in to access your lessons and flashcards.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
