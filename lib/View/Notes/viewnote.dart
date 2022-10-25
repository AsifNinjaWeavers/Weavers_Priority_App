import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../Model/note.dart';
import 'editnote.dart';
class ViewNote extends StatelessWidget {
  final Note note;
  ViewNote({required this.note, super.key});
  final screenshotcontroller = ScreenshotController();
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
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xf13b3b3b),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditNote(
                            note: note,
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit_note_sharp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xf1252525),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 20,
            bottom: 20,
          ),
          child: Screenshot(
            controller: screenshotcontroller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          wordSpacing: 2.5,
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat.yMMMMd().format(note.date).toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    wordSpacing: 2.5,
                    color: Colors.white54,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  note.notetext,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xf1252525),
        onPressed: () async {
          final image = await screenshotcontroller.capture();
          takescreenshot(image!);
        },
        child: const Icon(
          Icons.share,
        ),
      ),
    );
  }

  void takescreenshot(Uint8List image) async {
    // Share.shareFiles([imageFile.path]);
    // File f = imageFile as File;
    // await screenshotcontroller.capture(delay: const Duration(milliseconds: 10)).then((Uint8List image)

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/image.png').create();
    await imagePath.writeAsBytes(image);

    await Share.shareFiles([imagePath.path]);
  }
}
