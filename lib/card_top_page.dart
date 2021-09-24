import 'package:flutter/material.dart';

import 'add_card_page.dart';
import 'list_page.dart';
import 'search_page.dart';
import 'test_search_page.dart';

class CardTopPage extends StatefulWidget {
  // const CardTopPage({Key? key, required this.title}) : super(key: key);
  // final String title;
  @override
  State<CardTopPage> createState() => _CardTopPageState();
}
class _CardTopPageState extends State<CardTopPage> {
  late TextEditingController columnController ;
  String dropdownValue = 'name';
  var column = {'name':'名前','coName':'会社名','furigana':'ふりがな'};
  String _selectedKey = 'name';
  int _counter = 0;
  late TextEditingController controller;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    columnController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('てすと'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

            RaisedButton(
                child: Text('一覧ページへ'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
                }),

            RaisedButton(
                child: Text('テスト検索ページ'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TestSearchPage()));
                }),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('検索項目'),
                DropdownButton<String>(

                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.deepPurple
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['coName', 'tel', 'furigana', 'name']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
              ],
            ),


            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Enter keyword'),
            ),

            RaisedButton(
                child: Text('検索ページ'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(dropdownValue,controller.text)));
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}