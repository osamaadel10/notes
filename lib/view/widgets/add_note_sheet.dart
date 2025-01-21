import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cuibt/get_notes_cuibt/get_notes_cubit.dart';
import 'package:notes/models/note_model.dart';
import '../../cuibt/add_notes_cuibt/add_note_cubit.dart';
import 'circle_color.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({super.key});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

int? isSelected ;
List<int> colors = [
  Colors.red.value,
  Colors.grey.value,
  Colors.blue.value,
  Colors.cyan.value,
  Colors.purple.value,
  Colors.blueGrey.value,
  Colors.pinkAccent.value,
  Colors.indigo.value,
  Colors.teal.value,
  Colors.brown.value
];
class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? title, content;
  int? color;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          TextFormField(
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
            maxLines: 10,
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
                        color = colors[index];
                        isSelected = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: CircleColor(index: index ,isSelected: isSelected??0, color: colors[index],),
                    ),
                  );
                },
              )),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                BlocProvider.of<AddNoteCubit>(context).addNote(
                  context,
                  NoteModel(
                    title: title!,
                    descraption: content!,
                    colornote:color??Colors.red.value,
                    date:
                        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                    noteKey: "${DateTime.now()}"
                  ),
                );
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
              "Add",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

void addNoteSheet(BuildContext context) {
  showModalBottomSheet(
    enableDrag: true,
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
              child: NoteForm(),
            ),
          ),
        ),
      );
    },
  );
}
