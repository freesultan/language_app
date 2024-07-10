import 'package:flutter/material.dart';
  
class AddFlashcardWidget extends StatelessWidget {
  final String deckName;
  final Function(String, String, String) onAddFlashcard;
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  AddFlashcardWidget({required this.deckName, required this.onAddFlashcard});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showAddFlashcardDialog(context);
      },
      child: Text('Add Flashcard'),
    );
  }

  void _showAddFlashcardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Flashcard'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
                controller: _questionController,
          decoration: InputDecoration(labelText: 'Question'),
        ),
        TextField(
                controller: _answerController,
          decoration: InputDecoration(labelText: 'Answer'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
                final question = _questionController.text;
                final answer = _answerController.text;
                onAddFlashcard(deckName, question, answer);
                Navigator.pop(context);
              },
              child: Text('Add'),
        ),
      ],
        );
      },
    );
  }
}
