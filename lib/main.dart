import 'package:flutter/material.dart';
import 'package:language_app/screens/auth_screen.dart';
import 'package:language_app/screens/home_screen.dart';
import 'package:language_app/screens/loading_screen.dart';
import 'package:language_app/states/user_state.dart'; // Import the UserState class
import 'package:provider/provider.dart';

import 'package:language_app/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'learning app',
          theme: AppTheme.themeData,
          home: const SplashScreen(),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    // Check if user is logged in
    final userState = Provider.of<UserState>(context, listen: false);

    if (userState.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
