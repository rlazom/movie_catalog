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
    // getAllCategory();
  }

  sinkAllCategory() async {
    _controller.sink.add(await _categoryRepository.getAllCategory());
  }

  Future<List<CategoryModel>> getAllCategories() async =>
      _categoryRepository.getAllCategory();

  addCategory(CategoryModel category) async {
    await _categoryRepository.insertCategory(category);
    sinkAllCategory();
  }

  updateCategory(CategoryModel category) async {
    await _categoryRepository.updateCategory(category);
    sinkAllCategory();
  }

  deleteCategoryById(String id) async {
    _categoryRepository.deleteCategoryById(id);
    sinkAllCategory();
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

  findAudiovisualList(
      int limit, int skip, String category, String genre, String titulo) async {
    _controller.sink.add(await _audiovisualRepository.findAudiovisualList(
        limit, skip, category, genre, titulo));
  }

  findAudiovisualCount(String category, {String genre}) async {
    return _audiovisualRepository.findAudiovisualCount(category, genre: genre);
  }

  dispose() {
    _controller.close();
  }
}

class UserBloc {
  final UserRepository repository = UserRepository();

  Future login(String user, String pass) => repository.login(user, pass);

  Future signUp(String user, String pass, String email) =>
      repository.signUp(user, pass, email);

  Future logout() => repository.logout();
}