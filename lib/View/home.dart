import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/View/Notes/addnote.dart';
import 'package:to_do_app/View/homeitems/homebodydesign.dart';
import 'package:to_do_app/View/search.dart';
import 'package:to_do_app/View/homeitems/homesearchdelegate.dart';

import 'navbar.dart';

class HomeScreen extends StatefulWidget {
  Color notetextcolor = Colors.black;

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<Search>? searchbox;
  List<Search>? search;
  @override
  void initState() {
    super.initState();
    searchbox = Hive.box<Search>('SearchBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            drawer: NavDrawer(
              pickcolor: widget.notetextcolor,
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: SafeArea(
                child: Row(
                  children: [
                    Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.short_text,
                        color: Colors.black87,
                        size: 30,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width/140,),
                  ValueListenableBuilder(
                  valueListenable: searchbox!.listenable(),
                  builder: (BuildContext context, value, _) {
                    return GestureDetector(
                      onTap: (() =>
                      showSearch(
                              context: context,
                              delegate: HomeSearchDelegate(
                                  search: searchbox!.values.toList()))),
                      child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width/1.4,
                    height: MediaQuery.of(context).size.height/22,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10,),
                         const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                        const SizedBox(width: 15,),
                        Text('Search for Notes',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18,color: Colors.black54),),
                       
                      ],
                    ),
                      ),);}
                  ),
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset(
                      'assest/images/1f468.png',
                      fit: BoxFit.fill,
                    ),
                  )
                  ],
                ),
              ),
            ),
            backgroundColor: const Color(0xf1f9f8fe),
            body: HomeBodyDesign(notetextcolor: widget.notetextcolor),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endFloat,
                resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
                backgroundColor:  Colors.black54,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddNotes()),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          );
        }
  }
