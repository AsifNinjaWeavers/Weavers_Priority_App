import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Model/task.dart';

class CustomDismissible extends StatelessWidget {
  const CustomDismissible({
    Key? key,
    required this.archived,
    required this.taskbox,
    required this.items,
  }) : super(key: key);

  final Box<Task>? taskbox;
  final Task? items;
  final bool archived;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.topLeft,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(5),
        color: Colors.green,
        alignment: Alignment.topRight,
        child: Icon(
          Icons.archive,
          color: Colors.white,
        ),
      ),
      onDismissed: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          // taskbox!.clear();
          await taskbox!.delete(items?.taskkey);
        } else {
          await taskbox!.put(
              items!.taskkey,
              Task(
                  tasktext: items!.tasktext,
                  datetime: items!.datetime,
                  completed: items!.completed,
                  archived: archived,
                  taskkey: items!.taskkey));
          // taskbox!.listenable();
        }
      },
      key: Key(items!.taskkey),
      child: Container(
        // height:50,
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            color: const Color(0xf1f9f8fe),
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(95, 216, 139, 139))
            ],
            borderRadius: BorderRadius.circular(5)),
        // height: MediaQuery.of(context).size.height/15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                //  color: Colors.black,
                // height: MediaQuery.of(context).size.height / 31.82,
                width: MediaQuery.of(context).size.width / 1.35,
                padding: EdgeInsets.all(2),
                child: Text(
                  items!.tasktext,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 15),
                )),
            // const SizedBox(
            //   width: 5,
            // ),
            items!.completed == false
                ? Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.black)),
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.done,
                        size: 14,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        await taskbox!.put(
                            items!.taskkey,
                            Task(
                                tasktext: items!.tasktext,
                                datetime: items!.datetime,
                                completed: true,
                                archived: items!.archived,
                                taskkey: items!.taskkey));
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
