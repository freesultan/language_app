import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  final String frontText;
  final String backText;
  final bool isFlipped;

  Flashcard({required this.frontText, required this.backText, this.isFlipped = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(isFlipped ? backText : frontText),
        ),
      ),
    );
  }
}
