part of 'add_note_cubit.dart';

@immutable
sealed class AddNoteState {}

final class AddNoteInitial extends AddNoteState {}
final class AddNoteLaoding extends AddNoteState {}
final class AddNoteSuccess extends AddNoteState {}
final class AddNoteFailuer extends AddNoteState {
  final String error;

  AddNoteFailuer({required this.error});
}
