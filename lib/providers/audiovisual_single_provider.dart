import 'package:catalogo/data/moor_database.dart';
import 'package:catalogo/repository/repository_games.dart';
import 'package:catalogo/repository/repository_movie.dart';
import 'package:flutter/material.dart';

class AudiovisualProvider with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String type;
  final String year;
  final String imageUrl;
  bool isFavourite;

  AudiovisualProvider(
      {@required this.id,
      @required this.title,
      this.year,
      this.type,
      @required this.image,
      @required this.imageUrl,
      this.isFavourite});

  Future<bool> toggleFavourite({@required BuildContext context,AudiovisualTableData audiovisual}) async {
    isFavourite = !isFavourite;
    final _repository = MovieRepository(context);
    _repository.db.updateAudiovisual(audiovisual.copyWith(isFavourite: isFavourite));
    notifyListeners();
    return isFavourite;
  }

  Future findMyData(BuildContext context) async {
    final _repository = MovieRepository(context);
    var result = await _repository.getById(id);
    isFavourite = result?.isFavourite;
    return result;
  }
}
