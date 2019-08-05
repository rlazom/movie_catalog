import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/audiovisual/category.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/ui/audiovisual.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
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
    return StreamBuilder(
      stream: block.categories,
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        return getCategoryCardWidget(snapshot);
      },
    );
  }

  Widget getCategoryCardWidget(AsyncSnapshot<List<CategoryModel>> snapshot) {
    return new Container(
      child: new Center(
          child: new RefreshIndicator(
        child: snapshot != null &&
                snapshot.data != null &&
                snapshot.data.length != 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
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
        onRefresh: _refresh,
      )),
    );
  }

  Widget _buildItem(CategoryModel categoryModel) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () => _navigateToDetails(categoryModel),
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                categoryModel.name,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(CategoryModel category) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryDetail(
                  category: category,
                )));
    // loadData();
  }

  Future<void> _refresh() async {
    loadData();
  }
}

class CategoryDetail extends StatefulWidget {
  final CategoryModel category;

  const CategoryDetail({Key key, this.category}) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  var tabs = <Tab>[];
  var tabPages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    CategoryModel categoryModel = widget.category;
    double tabWidth = 0;
    if (categoryModel.genres.length <= 3) {
      tabWidth =
          MediaQuery.of(context).size.width / categoryModel.genres.length;
    }
    categoryModel.genres.forEach((g) {
      tabs.add(new Tab(
        child: Container(
          width: tabWidth > 0 ? tabWidth : null,
          alignment: Alignment.center,

          child: Text(
            g.name,
            textAlign: TextAlign.center,
          ),
        ),
      ));
      tabPages.add(new Container(
          child: AudiovisualList(category: categoryModel.id, genre: g.id)));
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.category.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: buildDefaultTabController(tabWidth),
    );
  }

  DefaultTabController buildDefaultTabController(double tabWidth) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                labelPadding: tabWidth > 0 ? EdgeInsets.all(0) : null,
                indicatorColor: Colors.black38,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black38,
                tabs: tabs,
              ),
            ),
          ),
          Expanded(
              flex: 10,
              child: Container(
                child: TabBarView(children: tabPages),
              ))
        ],
      ),
    );
  }
}
