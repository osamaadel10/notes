import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes/cuibt/edit_notes_cuibt/edit_note_cubit.dart';
import 'package:notes/cuibt/get_notes_cuibt/get_notes_cubit.dart';
import 'package:notes/models/note_model.dart';
import '../../main.dart';
import 'add_note_sheet.dart';
import 'circle_color.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key, required this.noteKey});
  final String noteKey;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? title, content;

  @override
  Widget build(BuildContext context) {
   var noteBox =  Hive.box<NoteModel>(boxNoteName);
   print(noteBox.keys);
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          TextFormField(
            initialValue: noteBox.get(widget.noteKey)?.title,
            onSaved: (value) {
              title = value;
            },
            validator: (value) {
              if (value?.isEmpty == true) {
                return "title is required";
              } else {
                return null;
              }
            },
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: "title..",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: noteBox.get(widget.noteKey)?.descraption,
            onSaved: (value) {
              content = value;
            },
            validator: (value) {
              if (value?.isEmpty == true) {
                return "content is required";
              } else {
                return null;
              }
            },
            minLines: 7,
            maxLines: 15,
            decoration: InputDecoration(
              hintText: "content..",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
              height: 50.h,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: CircleColor(index: index ,isSelected: isSelected, color: colors[index],),
                    ),
                  );
                },
              )),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              int color = 0;
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              if(isSelected != null){
                 color = colors[isSelected!];
              }
               BlocProvider.of<EditNoteCubit>(context).editNote(widget.noteKey, title, content, color);
               Navigator.pop(context);
               isSelected = null;
                BlocProvider.of<GetNotesCubit>(context).getNotes();
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: EdgeInsets.symmetric(horizontal: 120.w, vertical: 5.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Edit",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

void editNoteSheet(BuildContext context, String noteKey) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return BlocProvider(
        create: (context) => EditNoteCubit(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: EditNote(
                noteKey: noteKey,
              ),
            ),
          ),
        ),
      );
    },
  );
}
