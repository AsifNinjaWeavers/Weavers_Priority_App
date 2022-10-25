import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Model/profile.dart';

class NavDrawer extends StatefulWidget {
  Color? pickcolor;
  NavDrawer({required this.pickcolor});
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Box<Profile>? profile;
  @override
  void initState() {
    super.initState();
    profile = Hive.box<Profile>('ProfilBox');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width * 0.60,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
           DrawerHeader(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/13,),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assest/images/emoji.jpg'))),
            child: const Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Edit Notes Text Color'),
            onTap: () => {
              showPicker(),
            },
          ),
        ],
      ),
    );
  }

  Future showPicker() async {
    Color col = Colors.black;
    return showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: widget.pickcolor!,
            onColorChanged: ((value) => col = value),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              debugPrint(widget.pickcolor?.value.toString());
              setState(
                () {
                  profile!.isEmpty
                      ? profile!.add(Profile(notestextcolor: col.value))
                      : profile!.putAt(0, Profile(notestextcolor: col.value));
                  widget.pickcolor = col;
                },
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }
}
