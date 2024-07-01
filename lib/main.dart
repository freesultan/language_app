import 'package:flutter/material.dart';
import 'package:language_app/core/services/lesson_providor.dart';
import 'package:language_app/features/home/presentation/pages/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=> LessonProvider()),
    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'sultan language app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}