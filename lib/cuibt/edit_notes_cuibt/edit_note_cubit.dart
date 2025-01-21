import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes/main.dart';

import '../../models/note_model.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit() : super(EditNoteInitial());
 editNote(key, title, content, color) async {
  emit(EditNoteLoading());
  try {
    var noteBox = Hive.box<NoteModel>(boxNoteName);
    var note = noteBox.get(key)!;

    note.title = title ?? note.title;
    note.descraption = content ?? note.descraption;
    note.colornote = (color == 0 ) ? note.colornote : color;

    noteBox.putAt(key, note);

    emit(EditNoteSuccess());
  } catch (e) {
    emit(EditNoteFailuer());
  }
}
}
