import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Model/task.dart';
import '../../widget/CustomDismissible.dart';

class Archived extends StatefulWidget {
  const Archived({super.key});

  @override
  State<Archived> createState() => _ArchivedState();
}

class _ArchivedState extends State<Archived> {
  Box<Task>? taskbox;
  @override
  void initState() {
    super.initState();
    taskbox = Hive.box<Task>('TaskBox');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.red,
        padding: const EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: taskbox!.listenable(),
          builder: (BuildContext context, value, _) {
            return ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (contexta, index) {
                final items = value.getAt(index);
                if (items!.archived == true) {
                  return Column(
                    children: [
                       CustomDismissible(taskbox: taskbox, items: items,archived: false,),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          },
        ));
  }
}
