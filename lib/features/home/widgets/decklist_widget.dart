import 'package:flutter/material.dart';
import 'package:language_app/core/models/user.dart';
import 'package:language_app/core/services/auth_service.dart';
import 'package:provider/provider.dart';


 // import '../pages/flashcard_list_screen.dart';

class DeckListWidget extends StatelessWidget {
  final User user;

  DeckListWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final decks = authService.getDecksOfAUser(user);


    // log user
    print('User: ${user.username}');
    // Log the decks
    print('Decks: ${decks.keys.toList()}');


    return Scaffold(
      appBar: AppBar(
        title: Text('${user.username}\'s Decks'),
      ),
      body: ListView.builder(
        itemCount: decks.length,
        itemBuilder: (context, index) {
          final deckName = decks.keys.elementAt(index);
          final flashcards = decks[deckName]!;
          return ExpansionTile(
            title: Text(deckName),
            children: flashcards.map((flashcard) {
              return ListTile(
                title: Text(flashcard.question),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => FlashcardListScreen(deck: user.decks[index]),
                //     ),
                //   );
                // },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
