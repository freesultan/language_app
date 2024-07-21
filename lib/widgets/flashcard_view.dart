import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:language_app/core/models/flashcard.dart';

class FlashcardView extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardView({required this.flashcard, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        shadowColor: Colors.black54,
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/bg4.webp'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            width: 300,
            height: 400,
            child: Center(
              child: Text(
                flashcard.question,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
      back: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        shadowColor: Colors.black54,
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/bg3.webp'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            width: 300,
            height: 400,
            child: Center(
              child: Text(
                flashcard.answer,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
