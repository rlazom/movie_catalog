import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/ui/category_detail.dart';
import 'package:catalogo/ui/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class MyInheritedWidget extends InheritedWidget {
  final CategoryModel myCategory;
  final CategoryModel myGenre;

  MyInheritedWidget(
      {@required this.myCategory, this.myGenre, Widget child, Key key})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return this.myCategory.id != oldWidget.myCategory.id ||
        (this.myGenre != null && this.myGenre.id != oldWidget.myGenre.id);
  }

  static MyInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyInheritedWidget);
  }
}

class _HomePageState extends State<HomePage> {
  var title = 'Inicio';
  String selectedItemDrawerKey = '0';
  Widget actualBody;
  CategoryModel actualCategory;
  final CategoryBlock block = CategoryBlock();
  final AudiovisualBlock audiovisualBlock = AudiovisualBlock();

  @override
  void initState() {
    super.initState();
    actualBody = getHomePage();
  }

  void loadData() {
    block.sinkAllCategory();
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
          title,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              return showSearch(
                  context: context, delegate: AudiovisualSearchDelegate(
                    // category: actualCategory != null ? actualCategory.id : null
                  ));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
//                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Center(
                      child: Opacity(
                          opacity: 0.9,
                          child: Image.asset('assets/images/logo.png')))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: selectedItemDrawerKey == '0'
                        ? Colors.blueAccent
                        : Colors.white.withOpacity(0.7),
                  ),
                  title: Text('Inicio',
                      style: TextStyle(
                          color: selectedItemDrawerKey == '0'
                              ? Colors.blueAccent
                              : Colors.white)),
                  onTap: () {
                    setState(() {
                      actualBody = getHomePage();
                      title = 'Categorias';
                      selectedItemDrawerKey = '0';
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              Divider(
                height: 1,
                endIndent: 20,
                indent: 20,
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: FutureBuilder(
                    future: block.getAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<CategoryModel> list = snapshot.data;
                        return Column(
                          children: list.map((c) {
                            return getCategoryDrawerItem(c);
                          }).toList(),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body:
          actualBody, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListTile getCategoryDrawerItem(CategoryModel c) {
    return ListTile(
      onTap: () {
        goToCategoryDetail(c);
        Navigator.of(context).pop();
      },
      title: Text(
        c.name,
        style: TextStyle(
            color: selectedItemDrawerKey == c.id
                ? Colors.blueAccent
                : Colors.white,
            fontSize: 14),
      ),
      leading: Icon(Icons.blur_on,
          color: selectedItemDrawerKey == c.id
              ? Colors.blueAccent
              : Colors.white.withOpacity(0.7)),
      trailing: FutureBuilder(
        future: audiovisualBlock.findAudiovisualCount(c.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Text(
              snapshot.data.toString(),
              style:
                  TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
            );
          }
          return Text('-');
        },
      ),
    );
  }

  void goToCategoryDetail(final CategoryModel c) async {
    setState(() {
      actualBody = MyInheritedWidget(
        myCategory: c,
        child: new CategoryDetail(
//          category: c,
            ),
      );
      title = c.name;
      selectedItemDrawerKey = c.id;
      actualCategory = c;
    });
  }

  Widget getHomePage() {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/background.jpg'),
      //     fit: BoxFit.fill,
      //     colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
      //   )
      // ),
      child: RefreshIndicator(
        child: StreamBuilder(
          stream: block.categories,
          builder: (BuildContext context,
              AsyncSnapshot<List<CategoryModel>> snapshot) {
            return getCategoryCardWidget(context, snapshot);
          },
        ),
        onRefresh: () => _refresh(),
      ),
    );
  }

  Widget getCategoryCardWidget(
      BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
    int columns = (MediaQuery.of(context).size.width ~/ 120);
    return new Container(
      child:
          snapshot != null && snapshot.data != null && snapshot.data.length != 0
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, itemPosition) {
                    CategoryModel categoryModel = snapshot.data[itemPosition];
                    return _buildItem(categoryModel);
                  })
              : Center(
                  child: RaisedButton(
                    onPressed: () => loadData(),
                    child: Text('Refrescar'),
                  ),
                ),
    );
  }

  Widget _buildItem(CategoryModel categoryModel) {
    return GestureDetector(
      onTap: () => goToCategoryDetail(categoryModel),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10)),
        color: Colors.blue.withOpacity(0.3),
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              categoryModel.name,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    loadData();
  }
}
