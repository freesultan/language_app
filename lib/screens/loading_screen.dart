import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                'assets/logo.png',
                height: 200,  
              ),
            ),
            const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Default color for other letters
                  ),
                  children: [
                    TextSpan(
                      text: 'L',
                      style: TextStyle(
                          color: Colors.purple), // Purple color for "L"
                    ),
                    TextSpan(text: 'ang'),
                    TextSpan(
                      text: 'S',
                      style: TextStyle(
                          color: Colors.purple), // Purple color for "S"
                    ),
                    TextSpan(text: 'tar'),
                    ],
                ),
              ),
            const SizedBox(height: 10),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
