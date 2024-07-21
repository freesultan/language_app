import 'package:flutter/material.dart';

class DeckListHeader extends StatelessWidget {
  const DeckListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
    );
  }
}
