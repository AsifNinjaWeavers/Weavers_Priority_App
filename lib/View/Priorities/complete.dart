import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/Model/task.dart';
import 'package:to_do_app/widget/CustomDismissible.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({super.key});

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
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
                if (items!.completed == true && items.archived==false) {
                  return Column(
                    children: [
                       CustomDismissible(taskbox: taskbox, items: items,archived: true,),
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
        ),);
  }
}
