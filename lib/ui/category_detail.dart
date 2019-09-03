import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/ui/audiovisual_list.dart';
import 'package:catalogo/ui/home.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatelessWidget {
//  final tabs = <Tab>[];
//  final tabPages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    final categoryModel = MyInheritedWidget.of(context).myCategory;
    final tabs = <Tab>[];
    final tabPages = <Widget>[];
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
          child: MyInheritedWidget(
              myCategory: categoryModel,
              myGenre: g,
              child: new AudiovisualList())));
    });
    double tabWidth = -1;
//    if (categoryModel.genres.length <= 3) {
//      tabWidth =
//          MediaQuery.of(context).size.width / categoryModel.genres.length;
//    }

//    return CategoryTabDecorator(tabs: tabs, tabPages: tabPages, tabWidth: -1);
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
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

class CategoryTabDecorator extends StatelessWidget {
  const CategoryTabDecorator({
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
