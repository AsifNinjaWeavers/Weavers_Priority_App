// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class formfielwidget extends StatelessWidget {
  const formfielwidget({
    Key? key,
    required this.titleController,
    required this.noteController,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 10,
              top: 20,
            ),
            child: TextFormField(
              // initialValue: "asddf",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 35,
              ),
              maxLines: null,
              controller: titleController,
              decoration: const InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontSize: 35,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 10,
              top: 20,
            ),
            child: TextFormField(
              controller: noteController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(color: Colors.white, fontSize: 25),
              decoration: const InputDecoration(
                // fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                focusColor: Colors.white,
                // filled: true,
                hintText: 'Type something......',
                hintStyle: TextStyle(
                  color: Colors.white54,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
