import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'card_page.dart';
import 'highlighted_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ListPage());
}

class ListPage extends StatefulWidget {

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController controller = TextEditingController();
  final Stream<QuerySnapshot> _cardStream = FirebaseFirestore.instance.collection('card').snapshots();
  List<String> nameList = [];
  late Future<QuerySnapshot<Map<String, dynamic>>> searchResults;

  Future<void> deleteCard(String docId) async{
    var document = FirebaseFirestore.instance.collection('card').doc(docId);
    document.delete();

  }

  void search(String query, {bool isCaseSensitive = false}) {
    if (query.isEmpty) {
      setState(() {
      });
      return;
    }
    final Future<QuerySnapshot<Map<String, dynamic>>> hitItems = FirebaseFirestore.instance.collection('card').where('furigana',arrayContains: (element) {
      return element.toLowerCase().contains(query.toLowerCase());
    }).get as Future<QuerySnapshot<Map<String, dynamic>>>;
    setState(() {
      searchResults = hitItems;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('一覧表示画面'),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(

              // stream: _cardStream,
              stream: FirebaseFirestore.instance.collection('card').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
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
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Column(
                      children: [
                        ListTile(

                          title: Text(data['name'].toString()),
                          subtitle: Text(data['coName']),

                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CardPage(document)));
                          },

                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              showModalBottomSheet(context: context, builder: (context){
                                return SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.delete, color: Colors.redAccent,),
                                        title: Text('削除(長押し)'),
                                        onLongPress: ()async{
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
          ),
        ],
      ),
    );
  }
}
