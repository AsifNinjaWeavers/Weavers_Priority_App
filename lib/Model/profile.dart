// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
part 'profile.g.dart';

@HiveType(typeId: 2)
class Profile {
  // @HiveField(0)
  // String UserName;
  // @HiveField(1)
  // Image profileimage;
  @HiveField(0)
  int notestextcolor;

  Profile({
    // required this.UserName,
    this.notestextcolor = 4278190080,
    // required this.profileimage
  });
}
