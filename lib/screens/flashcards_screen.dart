import 'package:flutter/material.dart';
import 'package:language_app/widgets/flashcard.dart';
import 'package:language_app/utils/database_helper.dart';


class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() {
    print('Creating FlashcardScreen State');
    return _FlashcardScreenState();
  }
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<Map<String, dynamic>> flashcards = [];
  int currentIndex = 0;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    print('FlashcardScreen initState');
    _loadFlashcards();
  }

  void _loadFlashcards() async {
    print('Loading flashcards from database');
    DatabaseHelper db = DatabaseHelper.instance;
    List<Map<String, dynamic>> data = await db.queryAllRows();
    setState(() {
      flashcards = data;
      print('Flashcards loaded: ${flashcards.length} cards found');
    });
  }

  void _flipCard() {
    setState(() {
      isFlipped = !isFlipped;
      print('Card flipped. Is flipped: $isFlipped');
    });
  }

  void _nextCard() {
    setState(() {
      isFlipped = false;
      currentIndex = (currentIndex + 1) % flashcards.length;
      print('Navigating to next card. Current index: $currentIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Building FlashcardScreen UI');
    if (flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Flashcards')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var flashcard = flashcards[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Flashcards')),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          onDoubleTap: _nextCard,
          child: Flashcard(
            frontText: flashcard['front_text'],
            backText: flashcard['back_text'],
            isFlipped: isFlipped,
          ),
        ),
      ),
    );
  }
}