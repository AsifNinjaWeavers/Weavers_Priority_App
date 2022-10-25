import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_app/View/homeitems/itemdesign.dart';

import '../../Model/note.dart';
import '../../Model/profile.dart';


class NormalItemView extends StatefulWidget {
  final Color notextextcolor;
  NormalItemView({required this.notextextcolor, super.key});

  @override
  State<NormalItemView> createState() => _NormalItemViewState();
}

class _NormalItemViewState extends State<NormalItemView> {
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
          valueListenable: unpinbox!.listenable(),
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
                mainbox: unpinbox!,
                supportbox: pinbox!,
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




// FutureBuilder(
//       // future: ,
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const SizedBox(
//               height: 20, width: 20, child: CircularProgressIndicator());
//         } else if (!snapshot.hasData) {
//           return const Center(
//             child: Text(
//               'You have not added any notes',
//               style: TextStyle(color: Colors.white54, fontSize: 20),
//             ),
//           );
//         } else {
//           return GridView.custom(
//             shrinkWrap: true,
//             padding: const EdgeInsets.all(15),
//             gridDelegate: SliverQuiltedGridDelegate(
//               crossAxisCount: 4,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 8,
//               repeatPattern: QuiltedGridRepeatPattern.same,
//               pattern: [
//                 const QuiltedGridTile(2, 2),
//                 const QuiltedGridTile(2, 2),
//                 const QuiltedGridTile(2, 4),
//                 const QuiltedGridTile(4, 2),
//                 const QuiltedGridTile(2, 2),
//                 const QuiltedGridTile(2, 2),
//               ],
//             ),
//             childrenDelegate: SliverChildBuilderDelegate(
//               childCount: 1,
//               (context, index) => ItemDesign(index: index),
//             ),
//           );
//         }
//         ;
//       },
//     );