import 'package:flutter/material.dart';
  
class CreateDeckWidget extends StatelessWidget {
  final Function(String) onCreateDeck;
  final TextEditingController _deckNameController = TextEditingController();

  CreateDeckWidget({super.key, required this.onCreateDeck});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showCreateDeckDialog(context);
      },
      child: const Text('Create Deck'),
    );
  }

  void _showCreateDeckDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Deck'),
          content: TextField(
            controller: _deckNameController,
          decoration: const InputDecoration(labelText: 'Deck Name'),
        ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
        ElevatedButton(
          onPressed: () {
                final deckName = _deckNameController.text;
                onCreateDeck(deckName);
                Navigator.pop(context);
              },
              child: const Text('Create'),
        ),
      ],
    );
      },
    );
  }
}
