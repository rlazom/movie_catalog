import 'package:catalogo/providers/categories_provider.dart';

import '../screens/category_detail.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(CategoryDetailScreen.routeName, arguments: category);
          },
          splashColor: Colors.white,
          child: Container(color: Theme.of(context).accentColor),
        ),
        footer: GridTileBar(
            title: Text(
          category.title,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
