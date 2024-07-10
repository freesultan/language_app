import 'package:flutter/material.dart';
  
class CreateDeckWidget extends StatelessWidget {
  final Function(String) onCreateDeck;
  final TextEditingController _deckNameController = TextEditingController();

  CreateDeckWidget({required this.onCreateDeck});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showCreateDeckDialog(context);
      },
      child: Text('Create Deck'),
    );
  }

  void _showCreateDeckDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Deck'),
          content: TextField(
            controller: _deckNameController,
          decoration: InputDecoration(labelText: 'Deck Name'),
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
                final deckName = _deckNameController.text;
                onCreateDeck(deckName);
                Navigator.pop(context);
              },
              child: Text('Create'),
        ),
      ],
    );
      },
    );
  }
}
