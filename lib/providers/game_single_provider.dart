import 'package:catalogo/repository/repository_games.dart';
import 'package:catalogo/repository/repository_movie.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  final String id;
  final String title;
  final String platforms;
  final String year;
  final String imageUrl;
  bool isFavourite;

  GameProvider({this.id, this.title, this.platforms, this.year, this.imageUrl,
    this.isFavourite});

  Future<bool> toggleFavourite({@required BuildContext context}) async {
    final _repository = GamesRepository(context);
    isFavourite = await _repository.toogleFavorite(id, !isFavourite);
    notifyListeners();
    return isFavourite;
  }

  Future findMyData(BuildContext context) async {
    final _repository = GamesRepository(context);
    return await _repository.getById(id);
  }
}
