// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_app/widget/formfielwidget.dart';
import 'package:to_do_app/View/home.dart';

import '../../Model/note.dart';

class EditNote extends StatefulWidget {
  final Note note;
  // final String st;
  const EditNote({required this.note, super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    noteController = TextEditingController(text: widget.note.notetext);
  }

  late TextEditingController titleController =
      TextEditingController(text: widget.note.title);

  late TextEditingController noteController =
      TextEditingController(text: widget.note.notetext);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 40,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color(0xf13b3b3b),
                  ),
                  child: IconButton(
                    onPressed: (() => Navigator.pop(context)),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                    iconSize: 20,
                  ),
                ),
                actions: [
                  Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            widget.note.title = titleController.text.toString();
                            widget.note.notetext =
                                noteController.text.toString();
                            widget.note.date = DateTime.now();
                            final snackBar = SnackBar(
                              content: const Text(
                                'Note Updated',
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ]),
          ),
        ),
        backgroundColor: const Color(0xf1252525),
        body: formfielwidget(
            titleController: titleController, noteController: noteController));
  }
}
