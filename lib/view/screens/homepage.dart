import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/cuibt/get_notes_cuibt/get_notes_cubit.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/view/widgets/note_card.dart';
import '../widgets/add_note_sheet.dart';
import '../widgets/app_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addNoteSheet(context);
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
        body: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const App_Bar(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height - 190,
                      child: BlocBuilder<GetNotesCubit, GetNotesState>(
                        builder: (context, state) {
                          if (state is GetNotesInitial) {
                            BlocProvider.of<GetNotesCubit>(context).getNotes();
                          }
                          List<NoteModel> notes =
                              BlocProvider.of<GetNotesCubit>(context).notes ?? [];
                          return ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              return NoteCard(
                                noteModel: notes[index],
                                noteKey: notes[index].key,
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
