import 'dart:collection';

import 'package:catalogo/data/moor_database.dart';
import 'package:catalogo/graphql/resolver.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CategoryRepository {
  final resolver = Resolver();
  MyDatabase db;

  CategoryRepository({BuildContext context}) {
    db = Provider.of<MyDatabase>(context, listen: false);
  }

  Future<List<CategoryModel>> getAllCategory() async {
//    List<CategoryModel> allCategory = null;
    List<CategoryModel> allCategory = await resolver.getAllCategory();

    if (allCategory == null || allCategory.isEmpty) {
      var allDbCategory = await db.getAllCategorias();
      var list = allDbCategory
          .map((c) =>
              new CategoryModel(c.name, c.parent.toString(), c.id.toString()))
          .toList();
      var organizedList = organizeCategoryList(list);
      return await new Future<List<CategoryModel>>(() => organizedList);
    } else {
      var dbList = allCategory
          .map((c) => new CategoriaTableData(
              id: c.id, name: c.name, parent: c.idParent))
          .toList();
      db.insertCategoria(dbList);

      var list = organizeCategoryList(allCategory);
      return await new Future<List<CategoryModel>>(() => list);
    }
  }

  List<CategoryModel> organizeCategoryList(List<CategoryModel> allCategory) {
    List<CategoryModel> forgibenList = [];
    Map<String, CategoryModel> map = HashMap<String, CategoryModel>();

    allCategory.forEach((c) {
      if (c.idParent == null || c.idParent == 'null' || c.idParent.isEmpty) {
        var putIfAbsent = map.putIfAbsent(c.id, () => c);
      } else if (map.containsKey(c.idParent)) {
        map[c.idParent].genres.add(c);
      } else
        forgibenList.add(c);
    });
    forgibenList.forEach((c) {
      if (map.containsKey(c.idParent)) {
        map[c.idParent].genres.add(c);
      }
    });
    var list = map.values.toList();
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  Future insertCategory(CategoryModel category) =>
      resolver.createCategory(category);

  Future updateCategory(CategoryModel category) =>
      resolver.updateCategory(category);

  Future deleteCategoryById(String id) => resolver.deleteCategory(id);

  Future deleteAllCategory() => resolver.deleteAllCategory();
}

class AudiovisualRepository {
  final Resolver resolver = Resolver();
  MyDatabase db;

  AudiovisualRepository({BuildContext context}) {
    db = Provider.of<MyDatabase>(context, listen: false);
  }

  Future<List<AudiovisualModel>> findAudiovisualList(
      int limit, int skip, String category, String genre, String titulo) async {
//    return db.findAudiovisualList(limit, skip, category, genre, titulo);
//    print(list.length);
//
    return resolver.findAudiovisualList(limit, skip, category, genre, titulo);
  }

  findAudiovisualCount(String category, {String genre}) {
    return db.findAudiovisualCount(category, genre: genre);
//    return resolver.findAudiovisualCount(category, genre: genre);
  }
}
