import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController coNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bushoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController furiganaController = TextEditingController();
  TextEditingController gyoushuController = TextEditingController();
  TextEditingController kannkeiController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController yakushokuController = TextEditingController();


  Future<void> addCard() async{
    var collection = FirebaseFirestore.instance.collection('card');
    collection.add({
      'name': nameController.text,
      'coName': coNameController.text,
      'address': addressController.text,
      'busho': bushoController.text,
      'email': emailController.text,
      'fax': faxController.text,
      'furigana': furiganaController.text,
      'gyoushu': gyoushuController.text,
      'kannkei': kannkeiController.text,
      'post': postController.text,
      'tel': telController.text,
      'yakushoku': yakushokuController.text,
      'touroku': DateTime.now(),
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('あたらしい名刺を追加'),
      ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('会社名'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: coNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('部署'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: bushoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('役職'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: yakushokuController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('氏名'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('フリガナ'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: furiganaController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('郵便番号'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: postController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('住所'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('TEL'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: telController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('メールアドレス'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('ファックス'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: faxController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('業種'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: gyoushuController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text('関係'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: kannkeiController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),

                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,

                    child: RaisedButton(
                      color:  Theme.of(context).primaryColor,
                      onPressed: () async{
                        await addCard();
                        Navigator.pop(context);

                      },
                      child: Text('追加',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                )


              ],),
          ),
        )
    );
  }
}
