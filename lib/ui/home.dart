import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/ui/category.dart';
import 'package:catalogo/ui/category_detail.dart';
import 'package:catalogo/ui/login.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var title = 'Inicio';
  int selectedDrawerIndex = 0;
  Widget actualBody = new CategoryList();
  final CategoryBlock block = CategoryBlock();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    block.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Center(
                    child: Text(
                  'Catalogo',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ))),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.blueAccent,
              ),
              title: Text('Categorias',
                  style: TextStyle(
                      color: selectedDrawerIndex == 1
                          ? Colors.blueAccent
                          : Colors.black)),
              onTap: () {
                setState(() {
                  actualBody = CategoryList();
                  title = 'Categorias';
                  selectedDrawerIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            // StreamBuilder(
            //   stream: block.categories,
            //   builder: (BuildContext context,
            //       AsyncSnapshot<List<CategoryModel>> snapshot) {
            //     return getCategoryListTileList(context, snapshot);
            //   },
            // )
          ],
        ),
      ),
      body:
          actualBody, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getCategoryListTileList(
      BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
    return snapshot != null &&
            snapshot.data != null &&
            snapshot.data.length != 0
        ? Column(
            children: getChildren(snapshot.data),
          )
        : Center(
            child: RaisedButton(
              onPressed: () => loadData(),
              child: Text('Refrescar'),
            ),
          );
  }

  getChildren(List<CategoryModel> list) {
    List<Widget> result = [];
    for (int i = 0; i < list.length; i++) {
      var c = list[i];
      result.add(getCategoryListTile(i, c));
    }
    return result;
  }

  Widget getCategoryListTile(int index, CategoryModel categoryModel) {
    return ListTile(
      title: Text(categoryModel.name,
          style: TextStyle(
              color:
                  selectedDrawerIndex == 1 ? Colors.blueAccent : Colors.black)),
      onTap: () {
        setState(() {
          title = categoryModel.name;
          selectedDrawerIndex = index;
          if (index != 0)
            actualBody = new CategoryDetail(category: categoryModel);
          else
            actualBody = LoginPage();
        });
        Navigator.pop(context);
      },
    );
  }
}
