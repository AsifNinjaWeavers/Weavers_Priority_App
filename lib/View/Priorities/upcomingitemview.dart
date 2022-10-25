import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Model/task.dart';
import '../../widget/CustomDismissible.dart';

class UpcomingItemView extends StatefulWidget {
  const UpcomingItemView({super.key});

  @override
  State<UpcomingItemView> createState() => _UpcomingItemViewState();
}

class _UpcomingItemViewState extends State<UpcomingItemView> {
   Box<Task>? taskbox;
  @override
  void initState() {
    super.initState();
    taskbox = Hive.box<Task>('TaskBox');
  }
  @override
  Widget build(BuildContext context) {
        return ValueListenableBuilder(
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
                //  debugPrint(items!.taskkey!);
                if(items!.archived==false && items.completed==false)
                {
                   return  Column(
                      children: [
                        CustomDismissible(taskbox: taskbox, items: items,archived: true,),
                        const SizedBox(height: 5,)

                      ],
                    );
                }
                else
                {
                  return SizedBox();
                }
                  
              },
                  
                
            );
           
          },
        );
  }
}

