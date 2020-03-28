import '../providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_item.dart';

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CategoriesProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: catProvider.categories.length,
      itemBuilder: (ctx, i) => CategoryItem(
          category: catProvider.categories[i]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
