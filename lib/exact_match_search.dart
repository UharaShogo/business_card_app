import 'package:flutter/material.dart';

import 'search_page.dart';

class ExactMatchSearchPage extends StatefulWidget {
  const ExactMatchSearchPage({Key? key}) : super(key: key);

  @override
  _ExactMatchSearchPageState createState() => _ExactMatchSearchPageState();
}

class _ExactMatchSearchPageState extends State<ExactMatchSearchPage> {
  late TextEditingController columnController ;
  late TextEditingController controller;
  String dropdownValue = 'name';

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
        title: Text("完全一致検索ページ"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
    );
  }
}
