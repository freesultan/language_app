import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';
import '../models/flashcard.dart';

class AuthService with ChangeNotifier {
  late Box<User> _userBox;
  late Box _flashcardBox;

  User? _currentUser;

  AuthService() {
    _userBox = Hive.box('users');
    _flashcardBox = Hive.box('flashcards');
  }

  User? get currentUser => _currentUser;

  bool login(String username, String password) {
    final user = _userBox.values.cast<User?>().firstWhere(
          (user) => user?.username == username && user?.password == password,
          orElse: () => null,
        );
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool register(String username, String password) {
    if (_userBox.values.any((user) => user.username == username)) {
      return false;
    }
    final user = User()
      ..username = username 
      ..password = password;
    _userBox.add(user);
    return true;
  }
  Map<String, List<Flashcard>> getUserDecks() {
    if (_currentUser != null) {
      final decks = (_flashcardBox.get(_currentUser!.username, defaultValue: <String, List<Map<String, String>>>{}) as Map).cast<String, List<dynamic>>() ?? {};
       return decks.map((key, value) => MapEntry(key, value.map((item) => Flashcard(
        question : item['question'],
        answer : item['answer']
      )).toList()));
     }
    return {};
  }

  void addFlashcard(String deckName, String question, String answer) {
    if (_currentUser != null) {
      final decks = getUserDecks();
    if (decks.containsKey(deckName)) {
        decks[deckName]!.add(Flashcard(
          question: question,
          answer: answer
        ));
        _flashcardBox.put(_currentUser!.username, decks.map((key, value) => MapEntry(key, value.map((item) => {
          'question': item.question,
          'answer': item.answer,
        }).toList())));
       }
    }
  }


  void createDeck(String deckName) {
    if (_currentUser != null) {
      final decks = getUserDecks();
      if (!decks.containsKey(deckName)) {
        decks[deckName] = [];
            _flashcardBox.put(_currentUser!.username, decks.map((key, value) => MapEntry(key, value.map((item) => {
          'question': item.question,
          'answer': item.answer,
        }).toList())));
       }
    }
  }
}
