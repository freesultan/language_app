import 'package:hive/hive.dart';

part 'lesson.g.dart';

@HiveType(typeId: 1)
class Lesson extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  Lesson({required this.title, required this.content});
}
