import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/Constant/textConstant.dart';
import 'package:to_do_app/View/Priorities/archived.dart';
import 'package:to_do_app/View/Priorities/complete.dart';
import 'package:to_do_app/View/Priorities/upcomingatsk.dart';

import '../../Model/task.dart';

class TaskAdd extends StatefulWidget {
  const TaskAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskAdd> createState() => _TaskAddState();
  
}

class _TaskAddState extends State<TaskAdd> with TickerProviderStateMixin{
  TextEditingController taskController =TextEditingController();
  late TabController tabController;
 
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }
  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width / 1.01,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            // color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('My Priorities',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),),
              TabBar(
                // isScrollable: true,
                controller: tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black45,
                unselectedLabelStyle: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 13,),
                labelStyle: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 13,),
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text:TextConstant.archived,),
                  Tab(text:TextConstant.upcoming,),
                  Tab(text: TextConstant.overdue,),
                  Tab(text: TextConstant.completed,),
                ],
                ),Container(
                  //  padding: EdgeInsets.all(4),
                  // color: Colors.black,
                  height: 300,
                  width: MediaQuery.of(context).size.width / 1.02,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                     const SingleChildScrollView(
                       child: Archived(),
                     ),
                      SingleChildScrollView(
                        child: UpcimngTask(taskController: taskController),
                      ),
                      Container(
                        color: Colors.orange,
                      ),
                       const SingleChildScrollView(
                        // color: Colors.pink,
                        child: CompleteTask(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          ),
    );
  }
}

