import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());//메인 페이지 구동하기
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  // 위에 4줄은 그냥 무시
  // 밑에서부터 시작
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text('금호동 3가'),
          actions: [Icon(Icons.search,size: 40), Icon(Icons.menu, size: 40,), Icon(Icons.add_alert_outlined, size:40)],
        ),

        body: Container(
          height: 200,
          padding: EdgeInsets.all(20),
          child:Row(
            children: [
              Image.asset('gamer-6022003_1280.png', width: 200,),
              Container(
                width:300,
                alignment: Alignment.center,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('카메라 팝니다'),
                    Text('금호동 3가'),
                    Text('210,000원'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      Icon(Icons.favorite_border),
                      Text('4')
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        )

      )
    );
  }
}

