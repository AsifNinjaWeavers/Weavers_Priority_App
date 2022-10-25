import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/View/homeitems/itemdesign.dart';

import '../../Model/note.dart';
import '../../Model/profile.dart';

class PinnedItemView extends StatefulWidget {
  final Color notextextcolor;
  const PinnedItemView({required this.notextextcolor, super.key});

  @override
  State<PinnedItemView> createState() => _PinnedItemViewState();
}

class _PinnedItemViewState extends State<PinnedItemView> {
  Box<Profile>? profile;
  Box<Note>? pinbox;
  Box<Note>? unpinbox;
  List<Note> notes = [];
  List<Note> pinnotes = [];
  @override
  void initState() {
    super.initState();
    unpinbox = Hive.box<Note>('box');
    pinbox = Hive.box<Note>('PinBox');
    profile = Hive.box<Profile>('ProfilBox');
  }

  @override
  Widget build(BuildContext context) {
   return ValueListenableBuilder(
      valueListenable: profile!.listenable(),
      builder: (BuildContext context, value, Widget? child) {
        return ValueListenableBuilder(
          valueListenable: pinbox!.listenable(),
          builder: (BuildContext context, value, _) {
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                // childAspectRatio: MediaQuery.of(context).size.width /
                //     (MediaQuery.of(context).size.height / 1.4),
              ),
              itemBuilder: (context, index) => ItemDesign(
                profile: profile!,
                mainbox: pinbox!,
                supportbox: unpinbox!,
                notes: value.values.toList(),
                index: index,
              ),
            );
           
          },
        );
      },
    );
  }
}
