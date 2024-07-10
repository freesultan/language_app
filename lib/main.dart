import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/auth_service.dart';
import 'core/models/user.dart';
import 'core/models/lesson.dart';
import 'core/models/flashcard.dart';

import 'package:language_app/core/services/lesson_providor.dart';
import 'package:language_app/features/home/presentation/pages/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(LessonAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(FlashcardAdapter());
  }
  await Hive.openBox<User>('users');
  await Hive.openBox<Lesson>('lessons');
  await Hive.openBox('flashcards');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LessonProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
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
      debugShowCheckedModeBanner: false,
      title: 'learning app',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
