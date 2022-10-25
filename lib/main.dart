import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/Model/note.dart';
import 'package:to_do_app/Model/profile.dart';
import 'package:to_do_app/Model/task.dart';
import 'package:to_do_app/View/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'View/search.dart';

Future<void> main() async {
  await Hive.initFlutter();
  //
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(SearchAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Note>('box');
  await Hive.openBox<Note>('PinBox');
  await Hive.openBox<Profile>('ProfilBox');
  await Hive.openBox<Search>('SearchBox');
  await Hive.openBox<Task>('TaskBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: GoogleFonts.poppins(fontWeight: FontWeight.w500,)
          ),
          appBarTheme: const AppBarTheme(
          
            elevation: 0, // This removes the shadow from all App Bars.
          )),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
