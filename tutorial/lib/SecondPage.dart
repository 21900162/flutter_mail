import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.green,
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.all(10),
                ),
                Container(
                  color: Colors.blue,
                  width: 150,
                  height: 150,
                ),
              ],
            ),
            TextButton(onPressed: () {
              showDialog(context: context,
                  barrierDismissible: false,
                  builder: (BuildContext bctx)
              {
                return AlertDialog(
                  content: Text("게시글 등록을 원하시나요?"),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('네'),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                    },
                        child: Text('아니요')
                    ),
                  ]
                );
              }
              );
            }, child: Text('Text button')),
            OutlinedButton(
                onPressed: () {
                  final snackBar = SnackBar(content: const Text('SnackBar'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: (){
                      },

                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('Outlinedbutton')
            ),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add, size:20),
              label: Text('ElevatedButton')
            ),
            Row(
              children: [
                Padding(padding: const EdgeInsets.all(10)),
                Image.asset('asset/Image/HGU.png',
                width: 150,
                  height:150,
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.menu),
          label: 'Menu'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Home'
          ),
        ]
      ),
    );
  }
}
