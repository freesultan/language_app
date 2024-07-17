import 'package:flutter/material.dart';
import 'package:language_app/features/home/presentation/pages/user_list_screen.dart';
import '../../widgets/daily_lesson_widget.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/lesson_providor.dart';

import 'package:language_app/core/services/auth_service.dart';
import 'package:language_app/features/home/presentation/pages/login_screen.dart';
import 'package:language_app/features/home/presentation/pages/register_screen.dart';

import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var lessonProvider = Provider.of<LessonProvider>(context);
    var currentLesson = lessonProvider.lessons.first;

    final authService = Provider.of<AuthService>(context);
    final currentUser = authService.currentUser;

    return Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg3.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.blueAccent
                      .withOpacity(0.5), // Color overlay with opacity
                ),
              ),
            ),
            Center(
              child: currentUser != null
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
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/flesh.json',
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        Card(
                          color: Colors.lightBlue[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0), 
                            child: Text(
                              'Welcome to Language Learning App',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Tooltip(
                              message: 'Register',
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                  );
                                },
                                child: const Icon(Icons.person_add,
                                    size: 20, color: Colors.white),
                              ),
                            ),
                            // const SizedBox(width: 40),
                            Tooltip(
                              message: 'Login',
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.greenAccent,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                                child: const Icon(Icons.login,
                                    size: 20, color: Colors.white),
                              ),
                            ),
                            // const SizedBox(width: 40),
                            Tooltip(
                              message: 'Users List',
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.purpleAccent,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const UserListScreen()),
                                  );
                                },
                                child: const Icon(Icons.person,
                                    size: 20, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
            )
          ],
        ));
  }
}

PreferredSizeWidget? _buildAppBar(BuildContext context) {
  final authService = Provider.of<AuthService>(context);

  if (authService.currentUser != null) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Hello, ${authService.currentUser!.username}'),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightBlue[300],
      elevation: 10,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.lightBlue,
              Colors.lightBlueAccent
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
      ),
    );
  }
  return null;
}
