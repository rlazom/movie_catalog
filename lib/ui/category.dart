import 'dart:math';

import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/ui/category_detail.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final CategoryBlock block = CategoryBlock();
//  final AudiovisualBlock block = AudiovisualBlock();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    block.sinkAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: StreamBuilder(
        stream: block.categories,
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          return getCategoryCardWidget(context, snapshot);
        },
      ),
      onRefresh: () => _refresh(),
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
      onTap: () => _navigateToDetails(categoryModel),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        color: Colors.white,
        margin: EdgeInsets.all(10),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              categoryModel.name,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    loadData();
  }

  void _navigateToDetails(CategoryModel category) async {
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => CategoryDetail(
//                  category: category,
//                )));
    // loadData();
  }


}
