import 'package:flutter/cupertino.dart';

import 'package:hive/hive.dart';
part 'task.g.dart';
@HiveType(typeId: 5)
class Task{
  @HiveField(0)
  String tasktext;
  @HiveField(1)
  DateTime? datetime;
   @HiveField(2)
  bool completed;
  @HiveField(3)
  String taskkey;
  @HiveField(4)
  bool archived;
  Task({required this.tasktext,required this.datetime,required this.completed, this.taskkey="",required this.archived});
}