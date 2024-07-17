import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

class DeckListTile extends StatelessWidget {
  final String deckName;
  final bool deckIsEmpty;
  final VoidCallback onTap;

  const DeckListTile({
    required this.deckName,
    required this.deckIsEmpty,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blueAccent,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        shadowColor: Colors.black54,
        child: ListTile(
          title: Text(deckName,
              style: const TextStyle(color: Colors.white)),
          trailing: deckIsEmpty
              ? badge.Badge(
                  toAnimate: false,
                  shape: badge.BadgeShape.square,
                  badgeColor: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  badgeContent: const Text('Empty',
                      style: TextStyle(color: Colors.white)),
                )
              : null,
        ),
      ),
    );
  }
}
