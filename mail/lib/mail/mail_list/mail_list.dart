import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../mail.dart';
import '../mail_content/show_mail.dart';
import 'mail_card.dart';

class MailList extends StatefulWidget {
  MailList(this.title, {Key? key}) : super(key: key);
  String? title;

  @override
  State<MailList> createState() => _MailListState();
}

class _MailListState extends State<MailList> {

  final user = FirebaseAuth.instance.currentUser;
  late QuerySnapshot querySnapshot;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(//stream이란 데이터의 소스가 바뀔 때마다 새로운 밸류값을 전달해주는 객체
      stream: FirebaseFirestore.instance.collection('/mail').snapshots(),//mail이라는 컬렉션을 가져옴.
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        //아직 데이터가 다 가져와지지 않았다면 파란색 동그라미가 보여짐
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), //로딩되는 동그라미 보여주기
          );
        }

        List<Mail> mailDocs = [];

        //print(widget.title);

        if (snapshot.hasData) {
          print("데이터 수: ");
          print(snapshot.data!.docs.length);

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var one = snapshot.data!.docs[i];

            //'메일을 보낸 사람이나 받은 사람 중에 현재 사용자가 해당한다면' mailDocs list에 담아준다.
            if (one.get('writer') == user!.email ||
                one.get('recipient') == user!.email) {

              Timestamp t = one.get('time');//파이어베이스에서 time은 메일이 보내진 시간을 의미하는데, Timestamp 형태로 저장되기 때문에 형변환이 필요함
              print(one.get('time'));//console에서 보기
              String time = DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch).toString().split(" ")[0];
              //2022-07-04 10:45:45.473999 이런 형태라서, ' '를 기준으로 쪼개서 앞에 날짜만 가져옵니다.
              print(DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch).toString());
              print(time);
              time = time.replaceAll("-", ".");

              //Mail 생성자를 이용해 데이터를 담은 객체를 만들고 list에 추가 시켜준다.
              Mail mail = Mail(one.id,one.get('title'), one.get('content'), one.get('writer'), one.get('recipient'), time, one.get('read'), one.get('sent'));

              if (widget.title == "보낸 편지함") {
                if (one.get('writer') == user!.email) {
                  //trick: 내가 보낸 편지는 내가 열어볼때 read 값이 false이어도 이미 읽은 것으로 보여주기 위한 -> 생성자에 값을 다르게 넣어줌
                  Mail mymail = Mail(one.id,one.get('title'), one.get('content'), one.get('writer'), one.get('recipient'), time, true, one.get('sent'));
                  mailDocs.add(mymail);

                }
              }
              else if (widget.title == "받은 편지함") {
                if (one.get('recipient') == user!.email) {
                  mailDocs.add(mail);
                }
              }
              else if (widget.title == "임시 저장") {
                if (one.get('writer') == user!.email &&
                    one.get('sent') == false) {
                  mailDocs.add(mail);
                }
              }
              else if (widget.title == "모든 메일") {
                mailDocs.add(mail);
              }
              else {}

            }
          }
        }
        else{
          print("데이터가 없습니다. ");
        }
        //final mailDocs = snapshot.data!.docs;//docs에 접근

        return ListView.builder(
          //ListView.builder에 몇 개의 항목을 만들 것이고 몇 번째 항목에는 어떤 View를 그려주자라는 것을 알려주어야 한다.
          // itemCount가 이 몇 개에 해당하고, itemBuilder가 어떤 View를 그려주자 라는 것에 해당한다.
            itemCount: mailDocs.length,
            itemBuilder: (context, index) {

              //사용자가 클릭하면 반응함.
              return GestureDetector(
                onTap: () {
                  Get.to(ShowMail(mailDocs[index]));
                },
                //itemCount 갯수만큼, MailCard 를 가져와서 보여줌.
                child: MailCard(mailDocs[index]),
              );
            }
        );
      },

    );
  }
}