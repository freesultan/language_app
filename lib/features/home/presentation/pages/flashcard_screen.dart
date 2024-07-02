import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<Map<String, String>> flashcards = [
    {"question": "Hello", "answer": "سلام"},
    {"question": "Thank you", "answer": "تشکر"},
    // Add more flashcards here
  ];
  int currentIndex = 0;
  bool showAnswer = false;

  void nextFlashcard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
      showAnswer = false;
    });
  }

  void toggleFlashcard() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Text(
                  showAnswer
                      ? flashcards[currentIndex]['answer']!
                      : flashcards[currentIndex]['question']!,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: toggleFlashcard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(showAnswer ? 'Show Question' : 'Show Answer'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: nextFlashcard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
