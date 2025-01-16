import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes/cuibt/get_notes_cuibt/get_notes_cubit.dart';
import 'package:notes/models/note_model.dart';
import '../../cuibt/add_notes_cuibt/add_note_cubit.dart';
import '../../main.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key, required this.index});
  final int index;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? title, content;

  @override
  Widget build(BuildContext context) {
    var noteBox = Hive.box<NoteModel>(boxNoteName);
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          TextFormField(
            initialValue:  noteBox.values.elementAt(widget.index).title,
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
            initialValue:noteBox.values.elementAt(widget.index).descraption,
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
            minLines: 13,
            maxLines: 20,
            decoration: InputDecoration(
              hintText: "content..",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                
      noteBox.values.elementAt(widget.index).title =title??noteBox.values.elementAt(widget.index+1).title; 
      noteBox.values.elementAt(widget.index).descraption =content??noteBox.values.elementAt(widget.index+1).descraption; 
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
              "Add",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

void editNoteSheet(BuildContext context,int index) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return BlocProvider(
        create: (context) => AddNoteCubit(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: EditNote(index: index,),
            ),
          ),
        ),
      );
    },
  );
}
