import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cuibt/get_notes_cuibt/get_notes_cubit.dart';
import '../../cuibt/search_note/search_note_cubit.dart';
import '../../models/note_model.dart';
import '../widgets/note_card.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchNoteCubit(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                  child: BlocBuilder<SearchNoteCubit, String>(
                    builder: (context, keyWord) {
                      return TextFormField(
                        onChanged: (value) {
                          context.read<SearchNoteCubit>().updateKeyword(value);
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search, size: 25.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "Search...",
                          hintStyle: TextStyle(fontSize: 15.sp),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height - 120,
                  child: BlocBuilder<GetNotesCubit, GetNotesState>(
                    builder: (context, state) {
                      if (state is GetNotesInitial) {
                        BlocProvider.of<GetNotesCubit>(context).getNotes();
                      }
                      List<NoteModel> notes =
                          BlocProvider.of<GetNotesCubit>(context).notes ?? [];
                    
                      return BlocBuilder<SearchNoteCubit, String>(
                        builder: (context, keyWord) {
                          List<NoteModel> filteredNotes = notes.where((note) {
                            return note.title.contains(keyWord) ||
                                note.descraption.contains(keyWord) ||
                                note.date.contains(keyWord);
                          }).toList();
                    
                          return ListView.builder(
                            itemCount: filteredNotes.length,
                            itemBuilder: (context, index) {
                              return NoteCard(
                                noteModel: filteredNotes[index],
                                noteKey: filteredNotes[index].noteKey,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}