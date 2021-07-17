import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //←Firebaseを初期化する際に必要らしい
  await Firebase.initializeApp(); //←Firebaseを初期化
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'テストアプリ',
      home: MainScreen(),
    );
  }
}

final myController = TextEditingController();

String name = "";

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('firestoreへアップロード'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'your name'),
            onChanged: (text) {
              name = text;
            },
          ),
          TextField(
            controller: myController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Send a message'),
          ),
          ElevatedButton(
            child: Text('send!'),
            onPressed: () {
              //  ここにフォーカスするためのコード
              print("rankに$nameが$myControllerをpushしました");
              FirebaseFirestore.instance.collection('rank').add(
                {name: myController.text},
              );
            },
          ),
        ]),
      ),
    );
  }
}
