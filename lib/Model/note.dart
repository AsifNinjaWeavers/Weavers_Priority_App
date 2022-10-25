import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String title;

  @HiveField(1)
  String notetext;

  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String id;
  @HiveField(4)
  int color;
  @HiveField(5)
  bool pin;
  Note({
    required this.title,
    required this.notetext,
    required this.date,
    required this.id,
    required this.color,
    required this.pin,
  });
}
