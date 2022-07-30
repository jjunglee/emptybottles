import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//firebase crud
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

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("create button", style: TextStyle(color: Colors.white)),
              onPressed: () {
                String book = "플러터 배우기";
                firebaseFirestore.collection('books').doc('flutter').set(
                    {'page': 433, 'purchase?': false, 'title': '플러터 배우기'});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("read button", style: TextStyle(color: Colors.white)),
              onPressed: (){
                String title = "";
                firebaseFirestore.collection("books").doc("flutter").get().then((DocumentSnapshot ds){
                  //Map<String, dynamic> data = ds.data();
                  //title = data['title'];
                  //print(title);
                  print(ds.data());
                });
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("update button", style: TextStyle(color: Colors.white)),
              onPressed: (){
                firebaseFirestore.collection('books').doc('flutter').update({"page":543});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("delete button", style: TextStyle(color: Colors.white)),
              onPressed: (){
                firebaseFirestore.collection('books').doc('flutter').delete();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}