import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/Constant/textConstant.dart';
import 'package:to_do_app/Model/task.dart';
import 'package:to_do_app/View/Priorities/upcomingitemview.dart';

class UpcimngTask extends StatefulWidget {
  const UpcimngTask({
    Key? key,
    required this.taskController,
  }) : super(key: key);

  final TextEditingController taskController;
  
  @override
  State<UpcimngTask> createState() => _UpcimngTaskState();
}

class _UpcimngTaskState extends State<UpcimngTask> {
  bool _hide = false;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _hide == false
              ? GestureDetector(
                  onTap: () => setState(() {
                    _hide = true;
                  }),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.1,
                height: 25,
                    child: Text(
                      TextConstant.addtaskdialouge,
                      style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black,fontSize: 15),
                    ),
                  ),
                )
              : Container(
                width: MediaQuery.of(context).size.width/1.1,
                height: 25,
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    SizedBox(
                       height: 25,
                      width: MediaQuery.of(context).size.width/1.35,
                      child: TextFormField(
                        
                          style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black,fontSize: 15),
                          controller: widget.taskController,
                          decoration:  InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: TextConstant.tapontaskdialouge,
                              hintStyle: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black,fontSize: 15),),
                        ),
                    ),
                    const SizedBox(width: 10,),
                    SizedBox(
                      height: 25,
                      width: MediaQuery.of(context).size.width/15.5,
                      child:  IconButton(
                          padding: EdgeInsets.all(2),
                onPressed: (){
                  setState(() {
                   String datetime=DateTime.now().toString();
                  var task=Task(tasktext: widget.taskController.text.toString(), datetime: DateTime.now(), completed: false,taskkey:datetime,archived: false);
                  taskbox?.put(datetime, task);
                   _hide=false;
                    widget.taskController.clear();
                  });
                },
                alignment: Alignment.topCenter,
                icon: Icon(Icons.add,size: 20,)),
                    ),
                  ],
                ),
              ),
              
              const Divider(thickness: 1.5,height: 1,),
              const SizedBox(height: 15,),
              const UpcomingItemView(),
          
        ],
      ),
    );
  }
}
