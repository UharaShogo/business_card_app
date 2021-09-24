import 'package:business_card_app/card_top_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'top_menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //メールアドレス入力
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value){
                  setState(() {
                    email = value;
                  });
                },
              ),

              //パスワード入力
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value){
                  setState(() {
                    password = value;
                  });
                },
              ),
              
              Container(
                padding: EdgeInsets.all(8),
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('ユーザ登録'),
                  onPressed: () async{
                    try{
                      //メール/パスワードでユーザ登録
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.createUserWithEmailAndPassword(email: email, password: password);
                      
                      //ユーザ登録に成功した場合
                      //card_top_page画面に遷移
                      await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return CardTopPage();
                      }),
                      );
                    } catch (e){
                      //ユーザ登録に失敗した場合
                      setState(() {
                        infoText = "登録に失敗しました：${e.toString()}";
                      });
                    }
                  },
                )
              ),

              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                //ログインボタン
                child: OutlinedButton(
                  child: Text('ログイン'),
                  onPressed: () async{
                    try{
                      //メールアドレス/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signInWithEmailAndPassword(email: email, password: password);

                      //ログインに成功した場合
                      //card_top_pageに遷移
                      await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return CardTopPage();
                      }),
                      );
                    } catch (e) {
                      //ログインに失敗した場合
                      setState(() {
                        infoText = "ログインに失敗しました：${e.toString()}";
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
