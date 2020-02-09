import 'package:flutter/material.dart';
import 'package:suttrula/MainFetchData.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final List<String> listof = ["Aquarium","Amusement Park","Museum","Church","Funeral Home","Hindu Temple","Zoo","Park","Cemetery","Shopping Mall","Stadium","Synagogue","Natural Feature"];
  final List listof = [{"name":"Aquarium","id":"aquarium"},{"name":"Amusement Park","id":"amusement_park"},{"name":"Museum","id":"museum"},{"name":"Church","id":"church"},{"name":"Funeral Home","id":"funeral_home"},{"name":"Hindu Temple","id":"hindu_temple"},{"name":"Zoo","id":"zoo"},{"name":"Park","id":"park"},{"name":"Shopping Mall","id":"shopping_mall"},{"name":"Stadium","id":"stadium"},{"name":"Synagogue","id":"synagogue"},{"name":"Natural Feature","id":"natural_feature"}];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Place Categories",
          style: new TextStyle(fontSize: 19.0),
        ),
        backgroundColor: Color(0xFF42A5F5),
      ),
      body: new Container(
        child: new ListView.builder(
          itemBuilder: (_,int index)=>listDataItem(this.listof[index]['name'],this.listof[index]['id']),
          itemCount: this.listof.length,
        ),
      ),
      /*floatingActionButton: new FloatingActionButton(
          onPressed: null),*/
    );
  }
}
class listDataItem extends StatelessWidget {
final String itemName;
final String id;
listDataItem(this.itemName,this.id);
Widget build(BuildContext context) {
  return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainFetchData(this.id,this.itemName)),
        );
      },
      child:new Card(
    elevation: 7.0,
    child: new Container(
      margin: EdgeInsets.all(7.0),
      padding: EdgeInsets.all(6.0),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            child: new Text(itemName[0]),
            backgroundColor: Color(0xFF42A5F5),
            foregroundColor: Colors.white,
          ),

          new Padding(padding: EdgeInsets.all(8.0)),
          new Text(itemName,style: TextStyle(fontSize: 20.0,))

        ],

      ),


    ),
  ));
}
}

