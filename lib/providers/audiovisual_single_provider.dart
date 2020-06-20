import 'package:catalogo/data/moor_database.dart';
import 'package:catalogo/repository/repository_games.dart';
import 'package:catalogo/repository/repository_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AudiovisualProvider with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String type;
  final double voteAverage;
  final String year;
  final String imageUrl;
  bool isFavourite;
  bool imageLoaded = false;

  AudiovisualProvider(
      {@required this.id,
      @required this.title,
      this.year,
      this.type,
      this.voteAverage,
      @required this.image,
      @required this.imageUrl,
      this.isFavourite});

  Future<bool> toggleFavourite({@required BuildContext context,AudiovisualTableData audiovisual}) async {
    isFavourite = !isFavourite;
    final _repository = MovieRepository.getInstance(context);
    _repository.db.updateAudiovisual(audiovisual.copyWith(isFavourite: isFavourite));
    notifyListeners();
    return isFavourite;
  }

  Future toggleLoadImage() async {
    imageLoaded = !imageLoaded;
    notifyListeners();
  }

  Future checkImageCached() async{
    var file = await DefaultCacheManager().getFileFromCache(imageUrl);
    var exist = await file?.file?.exists();
    imageLoaded = exist ?? false;
    notifyListeners();
  }

  Future findMyData(BuildContext context) async {
    final _repository = MovieRepository.getInstance(context);
    var result = await _repository.getById(id);
    isFavourite = result?.isFavourite;
    return result;
  }

  Future findMyDataTitle(BuildContext context) async {
    final _repository = MovieRepository.getInstance(context);
    var result = await _repository.getByTitle(title);
    isFavourite = result?.isFavourite;
    return result;
  }
}
