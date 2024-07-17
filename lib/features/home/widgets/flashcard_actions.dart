import 'package:flutter/material.dart';

class FlashcardActions extends StatelessWidget {
  final VoidCallback onKnownPressed;
  final VoidCallback onReviewPressed;

  const FlashcardActions({
    required this.onKnownPressed,
    required this.onReviewPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.blueAccent,
              shadowColor: Colors.black,
              elevation: 5,
            ),
            onPressed: onKnownPressed,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.blueGrey,
              shadowColor: Colors.black,
              elevation: 5,
            ),
            onPressed: onReviewPressed,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.deepPurple[800],
              shadowColor: Colors.black,
              elevation: 5,
            ),
            onPressed: onReviewPressed,
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
    );
  }
}
