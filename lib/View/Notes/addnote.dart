// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/widget/formfielwidget.dart';

import '../../Model/note.dart';
import '../search.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  Box<Note>? box;
  Box<Search>? searchbox;
  @override
  void initState() {
    super.initState();
    box = Hive.box<Note>('box');
    searchbox = Hive.box<Search>('SearchBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: const EdgeInsets.only(left: 11, right: 25),
          child: AppBar(
              elevation: 0,
              leadingWidth: 40,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xf1252525),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xf13b3b3b),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                  iconSize: 20,
                ),
              ),
              actions: [
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xf13b3b3b),
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (titleController.text.toString().isEmpty) {
                          final snackBar = SnackBar(
                            content: const Text(
                              'You have not entered anything in title',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            backgroundColor: (Colors.white),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (noteController.text.toString().isEmpty) {
                          final snackBar = SnackBar(
                            content: const Text(
                              'You have not entered anything in note',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            backgroundColor: (Colors.white),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Note note = Note(
                            title: titleController.text.toString(),
                            notetext: noteController.text.toString(),
                            date: DateTime.now(),
                            id: DateTime.now().toString(),
                            color: getcolorcode(),
                            pin: false,
                          );

                          box?.put(DateTime.now().toString(), note);
                          searchbox?.add(Search(
                              title:
                                  titleController.text.toString().toLowerCase(),
                              noteid: DateTime.now().toString(),
                              note: note));
                          final snackBar = SnackBar(
                            content: const Text(
                              'Note Added',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            backgroundColor: (Colors.white),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ]),
        ),
      ),
      backgroundColor: const Color(0xf1252525),

      body: formfielwidget(
          titleController: titleController, noteController: noteController),
    );
  }
}

int getcolorcode() {
  List<int> col = [
    0xff1f6638f,
    0xff1ffab91,
    0xff1ffcc80,
    0xff1e7ed9b,
    0xff181deea,
    0xff1cf94da,
    0xff1f48fb1,
    0xff153cded,
    0xff19b86fb,
    0xff1feb866,
  ];
  int intValue = Random().nextInt(10);
  return col[intValue];
}
