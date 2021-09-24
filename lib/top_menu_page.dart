import 'package:business_card_app/card_top_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class TopMenuPage extends StatefulWidget {
  const TopMenuPage({Key? key}) : super(key: key);

  @override
  _TopMenuPageState createState() => _TopMenuPageState();
}

class _TopMenuPageState extends State<TopMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topメニュー'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('ようこそ名刺管理アプリへ!',style: TextStyle(fontSize:25),),

            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: RaisedButton(
                  child: Text('ログイン'),
                  onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

              }),
            ),

            // RaisedButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage()));
            //   Text('ログインする');
            // }),
          ],
        ),
      ),
    );
  }
}
