import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/Constant/textConstant.dart';
import 'package:to_do_app/Model/task.dart';
import 'package:to_do_app/View/Priorities/upcomingitemview.dart';
import 'package:uuid/uuid.dart';

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
                    Container(
                       height: 25,
                      width: MediaQuery.of(context).size.width/1.40,
                      child: TextFormField(
                        
                          style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black,fontSize: 15),
                          controller: widget.taskController,
                          decoration:  InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: TextConstant.tapontaskdialouge,
                              hintStyle: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black,fontSize: 15),),
                        ),
                    ),
                    const SizedBox(width: 2,),
                    SizedBox(
                      height: 25,
                      width: MediaQuery.of(context).size.width/15.5,
                      child:  IconButton(
                             padding: EdgeInsets.all(0),
                onPressed: ()async {
                  DateTime? date=await pickdateTime();
                  var uuid = Uuid();
                  var v4 = uuid.v4();
                  var task= Task(tasktext: widget.taskController.text.toString(), datetime: date, completed: false,taskkey:v4.toString() ,archived: false);
                  taskbox?.put(v4, task);
                  debugPrint(task.datetime.toString());
                  setState(() {
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
  Future<DateTime?>pickdateTime()async {
    DateTime? date=await pickdate();
    if(date==null)
    {
      return null;
    }
    else
    {
      TimeOfDay? time=await picktime();
      if(time==null)
      {
        return DateTime(date.year,date.month,date.day);
      }
      return DateTime(date.year,date.month,date.day,time.hour,time.minute);
    }
  }
  Future<DateTime?>pickdate()=>showDatePicker(context: context, initialDate: DateTime.now(), firstDate:  DateTime(2000), lastDate:  DateTime(2050));
  Future<TimeOfDay?>picktime()=>showTimePicker(context: context, initialTime:TimeOfDay(hour:  DateTime.now().hour, minute: DateTime.now().minute));
}
