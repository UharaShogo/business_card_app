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
  String dropdownValue = '選んでください';
  String _selectedKey = 'name';
  bool _isEnteredKeyword = false; //検索窓の入力、未入力の管理 false：未入力　　true：入力
  List<String> searchTargets =[];

  void getTargets(String query) {
    searchTargets.clear();
  }

  List<String> searchResults = [];

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

  Future<void> deleteCard(String docId) async{
    var document = FirebaseFirestore.instance.collection('card').doc(docId);
    document.delete();
  }

  Future<void> deleteCard1(String column, String data) async{
    var aid;
    await FirebaseFirestore.instance
        .collection('card')
        .where(column, isEqualTo: data)
        .get()
        .then(
            (QuerySnapshot snapshot) => {
          snapshot.docs.forEach((f) {
            aid = f.reference.id;
          }),
        });
    var document = FirebaseFirestore.instance.collection('card').doc(aid);
    document.delete();
  }

  void search(String query, {bool isCaseSensitive = false}) {
    final List<String> hitItems = searchTargets.where((element) {
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
                  searchTargets.clear();
                  final db = await FirebaseFirestore.instance;
                  var documents = await db.collection('card').get();
                  documents.docs.forEach((element) {
                    searchTargets.add(element[newValue.toString()]);
                  });
                  setState(() {
                    _selectedKey = newValue!;
                    dropdownValue = newValue.toString();
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

          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter keyword'),
            onChanged: (String val){
              if(val.length == 0){
                _isEnteredKeyword = false;
              }
              else {
                _isEnteredKeyword = true;
              }
              search(val);
            },
          ),
          _isEnteredKeyword !=false ? _buildListkouho(_selectedKey, searchResults) : _displayAllList(),

        ],
      ),
    );
  }

  //検索候補を表示するウィジェット
  Widget _buildListkouho(String key, List<String> results){
    return Flexible(
      child: ListView.builder(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailPage(_selectedKey,searchResults[index])));
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
                              await deleteCard1(key, searchResults[index]);
                              setState(() {
                                searchResults.removeAt(index);
                              });

                              Navigator.pop(context,true);

                            },
                          ),

                        ],
                      ),

                    );

                  });

                },
              ),
            );
          }
      ),
    );
  }



  Widget _displayAllList(){
     return Flexible(
        child: StreamBuilder<QuerySnapshot>(
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
      );
  }

}
