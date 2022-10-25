import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/Controller/priority_controller.dart';

import '../../Model/task.dart';
import '../../widget/CustomDismissible.dart';

class Overdues extends StatefulWidget {
  const Overdues({super.key});

  @override
  State<Overdues> createState() => _OverduesState();
}

class _OverduesState extends State<Overdues> {
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
                if (items!.completed==false&&PriorityController.checkoverdue(items.datetime) == true) {
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
