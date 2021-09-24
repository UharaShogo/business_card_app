import 'package:business_card_app/card_detail_page.dart';
import 'package:business_card_app/card_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestSearchPage extends StatefulWidget {
  const TestSearchPage({Key? key}) : super(key: key);

  @override
  _TestSearchPageState createState() => _TestSearchPageState();
}
late TextEditingController controller;

class _TestSearchPageState extends State<TestSearchPage> {
  // final List<String> searchTargets1 = List.generate(10, (index) => 'Something ${index + 1}');
  String dropdownValue = '選んでください';
  var column = {'name':'名前','coName':'会社名','furigana':'ふりがな'};
  String _selectedKey = 'name';

  List<String> searchTargets = [
    "りんご",
    "ごりら",
    "ラッパ",
    "狸",
    "きつね",
    "ねこ",
    "こま",
    "まんとひひ",
    "ヒント",
    "トマト",
    "トートロジー"
  ];
  List<String> searchTargets2 =[];

  void getTargets(String query) {
    searchTargets2.clear();
  }

  List<String> searchResults = [];

  void search(String query, {bool isCaseSensitive = false}) {
    // if (query.isEmpty) {
    //   setState(() {
    //     searchResults.clear();
    //   });
    //   return;
    // }
    final List<String> hitItems = searchTargets2.where((element) {
      if (isCaseSensitive) {
        return element.contains(query);
      }
      return element.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      searchResults = hitItems;
    });
  }
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('検索項目'),
              DropdownButton<String>(
                hint: Text("SELECT WORKSPACE"),

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
                onChanged: (String? newValue) async{
                  searchTargets2.clear();
                  final db = await FirebaseFirestore.instance;
                  var documents = await db.collection('card').get();
                  documents.docs.forEach((element) {
                    print(element[newValue.toString()]);
                    searchTargets2.add(element[newValue.toString()]);
                  });
                  setState(() {
                    _selectedKey = newValue!;
                    dropdownValue = newValue!.toString();
                  });
                },
                items: <String>['選んでください','coName', 'tel', 'furigana', 'name']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

              ),
            ],
          ),
          // RaisedButton(
          //   child: Text('LoadAlldocs'),
          //   onPressed: () async {
          //     // 指定コレクションのドキュメント一覧を取得
          //     final db = await FirebaseFirestore.instance;
          //         var documents = await db.collection('card').get();
          //     documents.docs.forEach((element) {
          //       print(element['name']);
          //       searchTargets2.add(element['name']);
          //     });
          //     // ドキュメント一覧を配列で格納
          //     setState(() {
          //
          //     });
          //   },
          // ),
          // ドキュメント情報を表示
          // Column(
          //   children: documentList.map((document) {
          //     return ListTile(
          //       title: Text('name:${document['name']}'),
          //     );
          //   }).toList(),
          // ),
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter keyword'),
            onChanged: (String val){
              search(val);
            },
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, index){

                if(searchResults.length  > 0){
                  Text('検索項目を選んでください');
                }
                return ListTile(
                  title: Text(searchResults[index]),
                  onTap: (){
                    // DocumentSnapshot snapshot = FirebaseFirestore.instance.collection('card').where(_selectedKey.toString(),isEqualTo: searchResults[index]).get() as DocumentSnapshot<Object?>;
                    // var doc = FirebaseFirestore.instance.collection('card').where(_selectedKey.toString(),isEqualTo: searchResults[index].toString());
                    var doc = FirebaseFirestore.instance.collection('card').where(_selectedKey.toString(),isEqualTo: searchResults[index].toString()).get();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailPage(_selectedKey,searchResults[index])));

                  },
                );
              }
          )
        ],
      ),
    );
  }
}
