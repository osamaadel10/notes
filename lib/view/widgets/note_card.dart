// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/view/widgets/edit_note.dart';
import '../../cuibt/get_notes_cuibt/get_notes_cubit.dart';
import '../../main.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.noteModel, required this.index});

  final NoteModel noteModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Color(noteModel.colornote),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              editNoteSheet(context,index);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Container(padding: EdgeInsets.only(bottom: 5.w), 
              child: Text(
                noteModel.title.toUpperCase(),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: SizedBox(height: 70.h,
              child: Text((noteModel.descraption.length > 50)?"${noteModel.descraption.substring(0,50)}....":noteModel.descraption,
                  style: TextStyle(
                    fontSize: 20.sp,
                  )),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete,color: Colors.red,size: 33,),
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("Are you sure you want to delete this note?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          var noteBox = Hive.box<NoteModel>(boxNoteName);
                          noteBox.deleteAt(index);
                          BlocProvider.of<GetNotesCubit>(context).getNotes();
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 30.w),
            child: Text(
              noteModel.date,
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
