import 'package:flutter/material.dart';

import 'add_card_page.dart';
import 'exact_match_search.dart';
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
                child: Text('一覧、検索ページ'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TestSearchPage()));
                }),
            RaisedButton(
                child: Text('完全一致検索ページ'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExactMatchSearchPage()));
                }),
            RaisedButton(
                child: Text('名刺追加ページ'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardPage()));
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