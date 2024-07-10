import 'package:hive/hive.dart';

part 'flashcard.g.dart';

@HiveType(typeId: 2)
class Flashcard {
  @HiveField(0)
  late String question;

  @HiveField(1)
  late String answer;


  Flashcard({required this.question, required this.answer});

}
