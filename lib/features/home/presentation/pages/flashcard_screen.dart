import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:language_app/core/services/auth_service.dart';
import '../../widgets/add_flashcard_widget.dart';
import '../../widgets/create_deck_widget.dart';
// import 'package:language_app/features/home/presentation/pages/flashcard_detail_screen.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flip_card/flip_card.dart';
import 'package:language_app/features/home/widgets/search_widget.dart';
import 'package:language_app/core/models/flashcard.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late AuthService authService;
  String? selectedDeck;
  // controling swapping card index
  PageController _pageController = PageController();

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

  void _deleteFlashcard(String deckName, Flashcard flashcard) {
    //to do: add delete functionality if is needed
    //authService.deleteFlashcard(deckName, flashcard);
    setState(() {});
  }

  void _markFlashcardAsKnown(String deckName, Flashcard flashcard) {
    // todo: add lithner functionality
    //authService.markFlashcardAsKnown(deckName, flashcard);
    setState(() {});
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SearchWidget(
          onAddFlashcard: (question, answer) {
            _addFlashcard(selectedDeck!, question, answer);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final decks = authService.getUserDecks();

    return Scaffold(
      appBar: selectedDeck != null
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedDeck = null;
                    _pageController = PageController();
                  });
                },
              ),
              title: Text('${selectedDeck!} Deck'),
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(
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
                      padding: const EdgeInsets.all(16.0),
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
                          ? const Center(child: Text('No decks available.'))
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                    shadowColor: Colors.black54,
                                    child: ListTile(
                                      title: Text(deckName,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      trailing: deckIsEmpty
                                          ? badge.Badge(
                                              toAnimate: false,
                                              shape: badge.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              badgeContent: const Text('Empty',
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
                            ? const Center(
                                child: Text('No flashcards available.'))
                            : PageView.builder(
                                controller: _pageController,
                                itemCount: decks[selectedDeck]!.length,
                                itemBuilder: (context, index) {
                                  var flashcard = decks[selectedDeck]![index];
                                  return Center(
                                    child: FlipCard(
                                      front: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        elevation: 8,
                                        shadowColor: Colors.black54,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image:
                                                  AssetImage('assets/bg4.webp'),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            width: 300,
                                            height: 400,
                                            child: Center(
                                              child: Text(
                                                flashcard.question,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      back: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        elevation: 8,
                                        shadowColor: Colors.black54,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image:
                                                  AssetImage('assets/bg3.webp'),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            width: 300,
                                            height: 400,
                                            child: Center(
                                              child: Text(
                                                flashcard.answer,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                    Container(
                      child: decks[selectedDeck]!.isEmpty
                          ? const SizedBox(height: 20)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.blueAccent,
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                  ),
                                  onPressed: () {
                                    _markFlashcardAsKnown(
                                        selectedDeck!,
                                        decks[selectedDeck]![
                                            _pageController.page!.toInt()]);
                                    if (decks[selectedDeck]!.isNotEmpty) {
                                      _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                  child: const Text(
                                    'I Know',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.blueGrey,
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                  ),
                                  onPressed: () {
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: const Text(
                                    'Review Tomorrow',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.deepPurple[800],
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                  ),
                                  onPressed: () {
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: const Text(
                                    'Review Later',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AddFlashcardWidget(
                            deckName: selectedDeck!,
                            onAddFlashcard: _addFlashcard),
                        ElevatedButton(
                          onPressed: _showSearchDialog,
                          child: const Text('Search words'),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
