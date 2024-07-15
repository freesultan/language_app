import 'package:flutter/material.dart';
import 'package:language_app/core/models/flashcard.dart';



class FlashcardDetailScreen extends StatefulWidget {
  final String deckName;
  final Flashcard flashcard;

  const FlashcardDetailScreen({super.key, required this.deckName, required this.flashcard});

  @override
  _FlashcardDetailScreenState createState() => _FlashcardDetailScreenState();
}

class _FlashcardDetailScreenState extends State<FlashcardDetailScreen> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckName),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg4.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  color: Colors.blueAccent,
                  child: Text(
                    showAnswer ? widget.flashcard.answer : widget.flashcard.question,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Deck'),
              ),
            ],
                    ),
          ),
      ),
      ),
    );
  }
}
