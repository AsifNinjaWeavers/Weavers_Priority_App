import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/View/homeitems/normalitemview.dart';
import 'package:to_do_app/View/homeitems/pinneditem.dart';
import 'package:to_do_app/View/homeitems/taskadd.dart';


import '../../Model/note.dart';

class HomeBodyDesign extends StatefulWidget {
  Color notetextcolor = Colors.black;
  HomeBodyDesign({required this.notetextcolor, super.key});

  @override
  State<HomeBodyDesign> createState() => _HomeBodyDesignState();
}

class _HomeBodyDesignState extends State<HomeBodyDesign> {
  Box<Note>? pinbox;
  Box<Note>? unpinbox;
  Color col = Colors.black;
  @override
  void initState() {
    super.initState();
    unpinbox = Hive.box<Note>('box');
    pinbox = Hive.box<Note>('PinBox');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pinbox!.listenable(),
      builder: (BuildContext context, value, _) {
        return SingleChildScrollView(
        
          child:Column(
            children: [
              TaskAdd(),
              Column(
                  children: [
                    SizedBox(
                      child: pinbox?.isEmpty == false?Container(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                                'Important Notes',
                                style: Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Color.fromARGB(240, 28, 28, 99),
                                    fontSize: 23,
                                    ),)
                            
                      ):null
                    ),
                  SizedBox(
                    child: pinbox?.isEmpty == false
                              ? PinnedItemView(notextextcolor: widget.notetextcolor):null,
                  ),
                   SizedBox(
                     child: pinbox?.isEmpty == false
                            ?   Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 20, top: 8),
                        child: Text(
                                'Normal Notes',
                                style: Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Color.fromARGB(240, 28, 28, 99),
                                    fontSize: 23,
                                    ),
                                // textDirection: TextDirection.rtl,
                              )
                            
                      ): null,
                   ),
                   SizedBox(
                     child: pinbox?.isEmpty == true
                            ?   Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 20, top: 8),
                        child: Text(
                                'Notes',
                                style: Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Color.fromARGB(240, 28, 28, 99),
                                    fontSize: 23,
                                   ),
                                // textDirection: TextDirection.rtl,
                              )
                            
                      ):null,
                   ),
                    NormalItemView(notextextcolor: widget.notetextcolor),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Future showPicker() {
    // raise the [showDialog] widget
    return showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: Colors.red,
            onColorChanged: ((value) {
              debugPrint(value.value.toString());
              col = Color(value.value);
            }),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ],
      ),
      context: context,
    );
  }
}

