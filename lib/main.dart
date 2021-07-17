import 'package:flutter/material.dart';
import 'package:sql_app/db/database.dart';
import 'package:sql_app/models/datamodel.dart';

//-> ref: https://github.com/DevStack06/Flutter-Tutorials
void main() {
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
  int _counter = 0;
  late DB db;
  List<DataModel> datas = [];
  bool fetching = true;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DB();
    getData();
  }

  void getData() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: fetching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text(datas[0].title),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //-------------------Insert Data-----------------------------
          //  db.insertData(DataModel(title: "Alali"));
          //-------------------Update Data------------------------------

          DataModel newData = datas[0];
          newData.title = "RiyadAlali"; // update name
          db.update(newData, 0); // index or id 0

          //----------------------Delete Data---------------------------
          /* db.delete(0);
          setState(() {
            datas.removeAt(0);
          });*/
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
