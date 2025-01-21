import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import '../../main.dart';
import '../../models/note_model.dart';

part 'get_notes_state.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesInitial());
  List<NoteModel>? notes;

  getNotes() async {
    var noteBox = Hive.box<NoteModel>(boxNoteName);
    notes = noteBox.values.toList();
    // rearranged notes
    notes = notes!.reversed.toList();
    emit(GetNotesSuccess(notes ?? []));
  }
}
