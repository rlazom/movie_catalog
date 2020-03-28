import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/widgets/audiovisual_grid.dart';
import 'package:provider/provider.dart';

import '../providers/categories_provider.dart';
import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatefulWidget {
  static const routeName = '/categoryDetail';

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category; //id
    final tabs = <Tab>[];
    final tabPages = <Widget>[];
    category.genres.forEach((g) {
      tabs.add(new Tab(
        child: Container(
          // width: tabWidth > 0 ? tabWidth : null,
          alignment: Alignment.center,
          child: Text(
            g.title,
            textAlign: TextAlign.center,
          ),
        ),
      ));
      tabPages.add(new Container(
        child: ChangeNotifierProvider.value(
          value: AudiovisualListProvider(
            category: category.id,
            genre: g.id,
          ),
          child: AudiovisualGrid(),
        ),
      ));
    });
    double tabWidth = -1;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
                color: Colors.blue,
                child: TabBar(
                  isScrollable: true,
                  labelPadding: tabWidth > 0 ? EdgeInsets.all(0) : null,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 18),
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
      ),
    );
  }
}
