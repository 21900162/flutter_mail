import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MailScreen extends StatefulWidget {
  MailScreen(this.title, {Key? key}) : super(key: key);
  String? title;// 생성자

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
      )
    );
  }
}
