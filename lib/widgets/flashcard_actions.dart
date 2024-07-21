import 'package:flutter/material.dart';

class FlashcardActions extends StatelessWidget {
  final VoidCallback onKnownPressed;
  final VoidCallback onReviewPressed;
  final VoidCallback onLearnPressed;

  const FlashcardActions({
    required this.onKnownPressed,
    required this.onReviewPressed,
    required this.onLearnPressed,
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
              backgroundColor: Colors.lightGreen,
              shadowColor: Colors.black,
              elevation: 5,
            ),
            onPressed: onKnownPressed,
            child: const Column(
              children: [
                Icon(Icons.check, color: Colors.white),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'I Know',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
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
             child: const Column(
              children: [
                Icon(Icons.schedule, color: Colors.white),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Review',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
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
             child: const Column(
              children: [
                Icon(Icons.book, color: Colors.white),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Learn',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
