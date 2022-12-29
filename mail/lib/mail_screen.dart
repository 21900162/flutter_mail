import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mail/mail_list/mail_list.dart';

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
        title: Text(widget.title.toString(),
        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 15
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MailList(widget.title),)
          ],
        ),
      )

    );
  }
}
