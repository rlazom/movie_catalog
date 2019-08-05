import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/ui/audiovisual_list.dart';
import 'package:flutter/material.dart';

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
  void initState() {
    CategoryModel categoryModel = widget.category;
    categoryModel.genres.forEach((g) {
      tabs.add(new Tab(
        child: Container(
          // width: tabWidth > 0 ? tabWidth : null,
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
  }

  @override
  Widget build(BuildContext context) {
    
    // double tabWidth = 0;
    // if (categoryModel.genres.length <= 3) {
    //   tabWidth =
    //       MediaQuery.of(context).size.width / categoryModel.genres.length;
    // }
    

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
      body: new MyTabDecorator(tabs: tabs, tabPages: tabPages, tabWidth: -1),
    );
  }
}

class MyTabDecorator extends StatelessWidget {
  const MyTabDecorator({
    Key key,
    @required this.tabs,
    @required this.tabPages,
    @required this.tabWidth,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Widget> tabPages;
  final double tabWidth;

  @override
  Widget build(BuildContext context) {
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
