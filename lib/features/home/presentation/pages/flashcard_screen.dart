import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:language_app/core/services/auth_service.dart';
import 'package:language_app/core/models/flashcard.dart';
import '../../widgets/add_flashcard_widget.dart';
import '../../widgets/create_deck_widget.dart';

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late AuthService authService;
  String? selectedDeck;

  @override
  void initState() {
    super.initState();
    authService = Provider.of<AuthService>(context, listen: false);
  }

  void _createDeck(String deckName) {
    authService.createDeck(deckName);
    setState(() {}); // Rebuild the widget to reflect the new deck
  }

  void _addFlashcard(String deckName, String question, String answer) {
    authService.addFlashcard(deckName, question, answer);
    setState(() {}); // Rebuild the widget to reflect the new flashcard
  }

  @override
  Widget build(BuildContext context) {
    final decks = authService.getUserDecks();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('bg2.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: selectedDeck == null
            ? Column(
                children: [
                  Expanded(
                    child: decks.isEmpty
                        ? Center(child: Text('No decks available.'))
                        : ListView.builder(
                            itemCount: decks.keys.length,
                            itemBuilder: (context, index) {
                              String deckName = decks.keys.elementAt(index);
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text(deckName),
                                  onTap: () {
                                    setState(() {
                                      selectedDeck = deckName;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                  CreateDeckWidget(onCreateDeck: _createDeck),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: decks[selectedDeck]!.isEmpty
                        ? Center(child: Text('No flashcards available.'))
                        : ListView.builder(
                            itemCount: decks[selectedDeck]!.length,
                            itemBuilder: (context, index) {
                              var flashcard = decks[selectedDeck]![index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text(flashcard.question),
                                   onTap: () {
                                    
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FlashcardDetailScreen(
                                            deckName: selectedDeck!,
                                            flashcard: flashcard,
                                          ),
                                        ),
                                      );
                                   
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                  AddFlashcardWidget(deckName: selectedDeck! , onAddFlashcard: _addFlashcard),
                ],
              ),
      ),
      ),
    );
  }
}

class FlashcardDetailScreen extends StatefulWidget {
  final String deckName;
  final Flashcard flashcard;

  FlashcardDetailScreen({required this.deckName, required this.flashcard});

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('bg4.webp'),
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
                  padding: EdgeInsets.all(24.0),
                  color: Colors.blueAccent,
                  child: Text(
                    showAnswer ? widget.flashcard.answer : widget.flashcard.question,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Deck'),
              ),
            ],
                    ),
          ),
      ),
      ),
    );
  }
}
