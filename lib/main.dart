import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/view/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cuibt/get_notes_cuibt/get_notes_cubit.dart';
import 'cuibt/setting_cubit/setting_cubit.dart';
import 'models/note_model.dart';

String boxNoteName = "boxnote";
late SharedPreferences prefs ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance() ;
  if( prefs.getString("them") == null) 
   {await prefs.setString("them", "dark");}
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(boxNoteName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNotesCubit>(create: (_) => GetNotesCubit()),
        BlocProvider<SettingCubit>(create: (_) => SettingCubit()),
      ],
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          final theme = context.read<SettingCubit>().them;
          return ScreenUtilInit(
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: theme,
                home: const Homepage(),
              );
            },
          );
        },
      ),
    );
  }
}
