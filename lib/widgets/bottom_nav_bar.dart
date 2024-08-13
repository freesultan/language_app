import 'package:flutter/material.dart';
import 'package:language_app/screens/flashcards_screen.dart';
 import 'package:language_app/screens/home_screen.dart';
 
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Lessons',
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.dataset),
          label: 'Flashcards',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context, 
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            break;
          case 1:
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const HomeScreen())
            );
            break;
         case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  FlashcardScreen())
              );
            break;
        }
      },
    );
  }
}
