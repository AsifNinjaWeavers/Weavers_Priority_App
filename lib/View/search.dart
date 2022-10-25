import 'package:hive/hive.dart';

import '../Model/note.dart';
part 'search.g.dart';

@HiveType(typeId: 3)
class Search {
  @HiveField(0)
  String title;
  @HiveField(1)
  String noteid;
  @HiveField(2)
  Note note;
  Search({required this.title, required this.noteid, required this.note});
}
