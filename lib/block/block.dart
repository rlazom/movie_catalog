import 'dart:async';

import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
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

class AudiovisualBlock {
  //Get instance of the Repository
  final _audiovisualRepository = AudiovisualRepository();

  final _controller = StreamController<List<AudiovisualModel>>.broadcast();

  get audiovisuales => _controller.stream;

  AudiovisualBlock() {
    // getCategory();
  }

  findAudiovisualList(int limit, int skip, String category, String genre, String titulo) async {
    _controller.sink.add(await _audiovisualRepository.findAudiovisualList(limit, skip, category, genre, titulo));
  }

  dispose() {
    _controller.close();
  }
}