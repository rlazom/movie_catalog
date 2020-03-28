import 'package:catalogo/repository/repository.dart';
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final List<Category> genres;

  Category({this.genres, @required this.id, @required this.title});
}

class CategoriesProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories {
    return [..._categories];
  }

  Future syncroCatagories(BuildContext context) async {
    final _categoryRepository = CategoryRepository(context: context);

    final list = await _categoryRepository.getAllCategory();
    var all;
    if (list != null) {
      all = list
          .map((c) => new Category(
              id: c.id,
              title: c.name,
              genres: c.genres
                  .map((g) => new Category(id: g.id, title: g.name))
                  .toList()))
          .toList();
    }
    _categories = all;
    notifyListeners();
  }
}
