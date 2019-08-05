import 'package:flutter/material.dart';

import 'ui/category.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var title = 'Inicio';
  int selectedDrawerIndex = 0;
  Widget actualBody = new CategoryList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Inicio', style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                actualBody = new CategoryList();
              });
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('1'),
              onTap: () {
                setState(() {
                  actualBody = CategoryList();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('2'),
              onTap: () {
                setState(() {
                  actualBody = Center(child: Text('data'),);
                });
                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
      body:
          actualBody, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
