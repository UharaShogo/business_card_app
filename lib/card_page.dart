import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_page.dart';

class CardPage extends StatelessWidget {
  var card;
  CardPage(this.card);

  List<String> fields = ['coName', 'busho', 'yakushoku', 'name', 'furigana', 'post', 'address', 'tel', 'email', 'fax', 'gyoushu', 'kannkei'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              card['name'],
            ),
            Visibility(
              visible: true,
              child: Text(
                card['coName'],
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: fields.length,
            itemBuilder: (context, index) {
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

                  Text(card[fields[index]],style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,),
                ],

              );

            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(card)));
          
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
