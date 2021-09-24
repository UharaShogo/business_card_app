import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'card_page.dart';

class SearchPage extends StatelessWidget {
  String column;
  String word;
  SearchPage(this.column,this.word);
  // const SearchPage({Key? key}) : super(key: key);

  Future<void> deleteCard(String docId) async{
    var document = FirebaseFirestore.instance.collection('card').doc(docId);
    document.delete();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance.collection('card').where(column,isEqualTo: word).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<
                  String,
                  dynamic>;
              return Column(
                children: [
                  ListTile(

                    title: Text(data['name'].toString()),
                    subtitle: Text(data['coName']),

                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CardPage(document)));
                    },

                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context, builder: (context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.delete, color: Colors.redAccent,),
                                  title: Text('削除(長押し)'),
                                  onLongPress: () async {
                                    await deleteCard(document.id);
                                    Navigator.pop(context);
                                  },
                                ),

                              ],
                            ),

                          );
                        });
                      },
                    ),

                  ),
                  Divider(thickness: 2,),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
