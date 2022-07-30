import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//user update data(use firebase)
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Route'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '회수할 수 있는 공병의 개수를 입력해주세요.'
                  ),
                  Container(
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _textController,
                                onSubmitted: _handleSubmitted
                            ),
                          ),
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: ()=> _handleSubmitted(_textController.text)),
                          ),
                        ],
                      )
                  )
                ]
            )
        )
    );
  }

  void _handleSubmitted(String text){
    String book = "플러터 배우기";
    firebaseFirestore.collection('books').doc('flutter').set(
        {'page': text, 'purchase?': false, 'title': '플러터 배우기'});
    print(text);
    _textController.clear();
  }
}



