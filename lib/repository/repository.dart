import 'dart:collection';

import 'package:catalogo/graphql/resolver.dart';
import 'package:catalogo/model/audiovisual/category.dart';
import 'package:catalogo/model/category/CategoryModel.dart';

class CategoryRepository {
  final resolver = Resolver();

  Future getAllCategory() async {
    List<CategoryModel> allCategory = await resolver.getAllCategory();
    List<CategoryModel> forgibenList = [];
    Map<String, CategoryModel> map = HashMap<String, CategoryModel>();

    allCategory.forEach((c) {
      if (c.idParent == null || c.idParent.isEmpty) {
        var putIfAbsent = map.putIfAbsent(c.id, () => c);
        print(putIfAbsent.name);
        print(c.name);
        print(c.id);
      }
      else if (map.containsKey(c.idParent)) {
        map[c.idParent].genres.add(c);
      } else
        forgibenList.add(c);
    });
    forgibenList.forEach((c) {
          if (map.containsKey(c.idParent)) {
            map[c.idParent].genres.add(c);
            print(c.genres.length);
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
