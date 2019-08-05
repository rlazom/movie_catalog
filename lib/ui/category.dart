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

