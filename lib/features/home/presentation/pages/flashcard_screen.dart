import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:language_app/core/services/auth_service.dart';
import '../../widgets/add_flashcard_widget.dart';
import '../../widgets/create_deck_widget.dart';
// import 'package:language_app/features/home/presentation/pages/flashcard_detail_screen.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flip_card/flip_card.dart';

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late AuthService authService;
  String? selectedDeck;
  int currentIndex = 0;

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

  void _nextFlashcard() {
    setState(() {
      currentIndex =
          (currentIndex + 1) % authService.getUserDecks()[selectedDeck]!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final decks = authService.getUserDecks();

    return Scaffold(
      appBar: selectedDeck != null
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedDeck = null;
                    currentIndex = 0;
                  });
                },
              ),
              title: Text('${selectedDeck!} Deck'),
            )
          : null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: selectedDeck == null
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Card(
                        color: Colors.lightBlue[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 10,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Here is your Decks',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: decks.isEmpty
                          ? Center(child: Text('No decks available.'))
                          : ListView.builder(
                              itemCount: decks.keys.length,
                              itemBuilder: (context, index) {
                                String deckName = decks.keys.elementAt(index);
                                bool deckIsEmpty = decks[deckName]!.isEmpty;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDeck = deckName;
                                    });
                                  },
                                  child: Card(
                                    color: Colors.blueAccent,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                    shadowColor: Colors.black54,
                                    child: ListTile(
                                      title: Text(deckName,
                                          style:
                                              TextStyle(color: Colors.white)),
                                      trailing: deckIsEmpty
                                          ? badge.Badge(
                                              toAnimate: false,
                                              shape: badge.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              badgeContent: Text('Empty',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          : null,
                                    ),
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
                          : Center(
                              child: FlipCard(
                                front: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.black54,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
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
                                          decks[selectedDeck]![currentIndex]
                                              .question,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
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
                                      image: DecorationImage(
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
                                          decks[selectedDeck]![currentIndex]
                                              .answer,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _nextFlashcard,
                          child: Text('I Know'),
                        ),
                        ElevatedButton(
                          onPressed: _nextFlashcard,
                          child: Text('Review Tomorrow'),
                        ),
                        ElevatedButton(
                          onPressed: _nextFlashcard,
                          child: Text('Review Later'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    AddFlashcardWidget(
                        deckName: selectedDeck!, onAddFlashcard: _addFlashcard),
                  ],
                ),
        ),
      ),
    );
  }
}
