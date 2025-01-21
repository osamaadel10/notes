import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String descraption;
  @HiveField(2)
  int colornote;
  @HiveField(3)
  String date;
  @HiveField(4)
  String noteKey;
  NoteModel(
      {required this.title,
      required this.descraption,
      required this.colornote,
      required this.date,
      required this.noteKey});
}
