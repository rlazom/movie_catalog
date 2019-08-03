import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/audiovisual/category.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
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
            ? ListView.builder(
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
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            categoryModel.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    loadData();
  }
}
