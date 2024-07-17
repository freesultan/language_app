import 'package:flutter/material.dart';
import 'package:language_app/features/home/widgets/deck_list_tile.dart';
import 'package:language_app/features/home/widgets/flashcard_actions.dart';
import 'package:language_app/features/home/widgets/flashcard_view.dart';

import 'package:provider/provider.dart';
import 'package:language_app/core/services/auth_service.dart';
import '../../widgets/add_flashcard_widget.dart';
import '../../widgets/create_deck_widget.dart';
// import 'package:language_app/features/home/presentation/pages/flashcard_detail_screen.dart';
import 'package:language_app/features/home/widgets/search_widget.dart';
import 'package:language_app/core/models/flashcard.dart';
import 'package:language_app/features/home/widgets/deck_list_header.dart';

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
      appBar: _buildAppBar(),
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
              ? _buildDeckList(decks)
              : _buildFlashcardView(decks[selectedDeck]!),
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return selectedDeck != null
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
        : null;
  }

  Widget _buildDeckList(Map<String, List<Flashcard>> decks) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DeckListHeader(),
        ),
        Expanded(
          child: decks.isEmpty
              ? const Center(child: Text('No decks available.'))
              : ListView.builder(
                  itemCount: decks.keys.length,
                  itemBuilder: (context, index) {
                    String deckName = decks.keys.elementAt(index);
                    bool deckIsEmpty = decks[deckName]!.isEmpty;
                    return DeckListTile(
                        deckName: deckName,
                        deckIsEmpty: deckIsEmpty,
                        onTap: () {
                          setState(() {
                            selectedDeck = deckName;
                          });
                        });
                  },
                ),
        ),
        CreateDeckWidget(onCreateDeck: _createDeck),
      ],
    );
  }

  Widget _buildFlashcardView(List<Flashcard> flashcards) {
    return Column(
      children: [
        Expanded(
            child: flashcards.isEmpty
                ? const Center(child: Text('No flashcards available.'))
                : PageView.builder(
                    controller: _pageController,
                    itemCount: flashcards.length,
                    itemBuilder: (context, index) {
                      var flashcard = flashcards[index];
                      return Center(child: FlashcardView(flashcard: flashcard));
                    })),
        FlashcardActions(
          onKnownPressed: () {
            _markFlashcardAsKnown(
                selectedDeck!, flashcards[_pageController.page!.toInt()]);
            if (flashcards.isNotEmpty) {
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            }
          },
          onReviewPressed: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          }, 
          onLearnPressed: () { 
            // to do: add learn functionality
           },
        ),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AddFlashcardWidget(
                deckName: selectedDeck!, onAddFlashcard: _addFlashcard),
            ElevatedButton(
              onPressed: _showSearchDialog,
              child: const Text('Search words'),
            ),
          ],
        ),
      ],
    );
  }
}
