import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/models/note_model.dart';

import '../../main.dart';
part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  addNote(BuildContext context,NoteModel noteModel) async{
    emit(AddNoteLaoding());
    try{
      var noteBox = Hive.box<NoteModel>(boxNoteName);
      noteBox.put(noteModel.noteKey,noteModel);
      Navigator.pop(context);
      emit(AddNoteSuccess());
    }catch(e){
      emit(AddNoteFailuer(
        error: e.toString(),
      ));
    }
  }
}
