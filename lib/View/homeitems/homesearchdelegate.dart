import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/View/Notes/viewnote.dart';

import '../../Model/note.dart';
import '../search.dart';


class HomeSearchDelegate extends SearchDelegate {
  Box<Note>? pinbox;
  Box<Note>? unpinbox;
  List<Search> search;
  HomeSearchDelegate({required this.search});
  @override
  void initState() {
    unpinbox = Hive.box<Note>('box');
    pinbox = Hive.box<Note>('PinBox');
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future<List<Search>> searchlist(String str1) async {
      List<Search> ans = [];
      for (int i = 0; i < search.length; i++) {
        if (search[i].title.contains(str1)) {
          ans.add(search[i]);
        }
      }
      return ans;
    }

    return FutureBuilder(
      future: query.isEmpty ? null : searchlist(query.toLowerCase()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: null,
          );
        }else if(snapshot.data.length==0)
        {
           return  Center(
            child: Text('Not Available',style: Theme.of(context).textTheme.headline1,),
          );
        } 
        else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: ((context, index) {
                return Container(
                  // color: Colors.orange,
                  child: Column(
                    children: [
                      ListTile(
                        hoverColor: Colors.black45,
                        title: Text(
                          snapshot.data[index].note.title,
                          style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black, fontSize: 18),
                        ),
                        trailing: Icon(Icons.north_west),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ViewNote(
                              note: snapshot.data[index].note,
                            );
                          }),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              }));
        }
      },
    );
  }
}
