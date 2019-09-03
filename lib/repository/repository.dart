import 'dart:collection';

import 'package:catalogo/graphql/resolver.dart';
import 'package:catalogo/model/audiovisual/category.dart';
import 'package:catalogo/model/category/CategoryModel.dart';

class CategoryRepository {
  final resolver = Resolver();

  Future<List<CategoryModel>> getAllCategory() async {
    List<CategoryModel> allCategory = await resolver.getAllCategory();
    List<CategoryModel> forgibenList = [];
    Map<String, CategoryModel> map = HashMap<String, CategoryModel>();

    allCategory.forEach((c) {
      if (c.idParent == null || c.idParent.isEmpty) {
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

    return await new Future<List<CategoryModel>>(() => map.values.toList());
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

  Future findAudiovisualList(
          int limit, int skip, String category, String genre, String titulo) =>
      resolver.findAudiovisualList(limit, skip, category, genre, titulo);

  findAudiovisualCount(String category, {String genre}) =>
      resolver.findAudiovisualCount(category, genre: genre);
}

class UserRepository {
  final Resolver resolver = Resolver();

  Future login(String user, String pass) => resolver.login(user, pass);

  Future signUp(String user, String pass, String email) =>
      resolver.signUp(user, pass, email);

  Future logout() => resolver.logout();
}
