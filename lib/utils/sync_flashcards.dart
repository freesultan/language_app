import 'dart:convert';
import 'package:http/http.dart' as http;
import 'database_helper.dart';


Future<void> syncFlashcards(int userId) async {
  print('Starting flashcard synchronization for user $userId');
  try {
    final response = await http.get(Uri.parse('http://146.70.158.243/api/flashcards?userId=$userId'));

    if (response.statusCode == 200) {
      List<dynamic> flashcards = jsonDecode(response.body);
      print('Received ${flashcards.length} flashcards from server');
      DatabaseHelper db = DatabaseHelper.instance;

      for (var flashcard in flashcards) {
        print('Syncing flashcard: ${flashcard['id']}');
        await db.insert({
          DatabaseHelper.columnId: flashcard['id'],
          DatabaseHelper.columnFrontText: flashcard['front_text'],
          DatabaseHelper.columnBackText: flashcard['back_text'],
          DatabaseHelper.columnStatus: flashcard['status'],
          DatabaseHelper.columnLastReviewed: flashcard['last_reviewed'],
        });
      }
      print('Flashcards synchronized successfully');
    } else {
      print('Failed to fetch flashcards. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error during flashcard synchronization: $error');
  }
}
