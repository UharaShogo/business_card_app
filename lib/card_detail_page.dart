import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_page.dart';

class CardDetailPage extends StatelessWidget {
  String _selectedColumn;
  String value;
  CardDetailPage(this._selectedColumn, this.value);
  var edit ;
  List<String> fields = ['coName', 'busho', 'yakushoku', 'name', 'furigana', 'post', 'address', 'tel', 'email', 'fax', 'gyoushu', 'kannkei'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('名刺詳細ページ'),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('card').where(_selectedColumn,isEqualTo: value).snapshots(),
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
              edit = document;
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: fields.length,
                  itemBuilder: (context, index){
                    return Row(
                      children: [
                        Container(
                          width: 80,
                          child: Text(fields[index],style: TextStyle(fontSize: 16),),
                        ),
                        Container(
                          width: 20,
                          child: Text(':',style: TextStyle(fontSize: 16),),
                        ),

                        Text(data[fields[index]],style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,),
                      ],
                    );
                  });
            }).toList(),
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(edit)));
            },
            child: Icon(Icons.edit),
    ),
    );
  }
}
