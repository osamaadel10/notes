import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/view/screens/homepage.dart';
import 'cuibt/get_notes_cuibt/get_notes_cubit.dart';
import 'models/note_model.dart';

String boxNoteName = "boxnote";
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox<NoteModel>(boxNoteName);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, context) {
      return BlocProvider(
        create: (context) => GetNotesCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: const Homepage(),
        ),
      );
    });
  }
}
