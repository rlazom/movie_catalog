import 'dart:async';

import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/repository/repository.dart';

class CategoryBlock {
  //Get instance of the Repository
  final _categoryRepository = CategoryRepository();

  final _controller = StreamController<List<CategoryModel>>.broadcast();

  get categories => _controller.stream;

  CategoryBlock() {
    // getCategory();
  }

  getAllCategory() async {
    _controller.sink.add(await _categoryRepository.getAllCategory());
  }

  addCategory(CategoryModel category) async {
    await _categoryRepository.insertCategory(category);
    getAllCategory();
  }

  updateCategory(CategoryModel category) async {
    await _categoryRepository.updateCategory(category);
    getAllCategory();
  }

  deleteCategoryById(String id) async {
    _categoryRepository.deleteCategoryById(id);
    getAllCategory();
  }

  dispose() {
    _controller.close();
  }
}
