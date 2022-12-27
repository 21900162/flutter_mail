import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/home.dart';

class MailApp extends StatelessWidget {
  const MailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:Firebase.initializeApp(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(
              child: Text("Firebase load failed"),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return HomePage();
          }
          return const CircularProgressIndicator();//앱 진행상황을 나타낼 때 가장 많이 사용되는 위젯. 원형이 계속해서 돌아감
        }
        );
  }
}
