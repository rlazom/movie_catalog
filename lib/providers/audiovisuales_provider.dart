import 'dart:convert';

import '../providers/audiovisual_single_provider.dart';
import '../repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class AudiovisualListProvider with ChangeNotifier {
  final String category;
  final String genre;
  final String type;

  AudiovisualListProvider({this.type, this.category, this.genre});

  List<AudiovisualProvider> _items = [];

  List<AudiovisualProvider> get items {
    return [..._items];
  }

  AudiovisualProvider findById(String id) {
    return _items.firstWhere((av) => av.id == id);
  }

  Future syncroAudiovisuals(BuildContext context) async {
    final _categoryRepository = AudiovisualRepository(context: context);

    final list = await _categoryRepository.findAudiovisualList(
        999, null, category, genre, null);
    for (var a in list) {
      var aa = new AudiovisualProvider(
          title: a.titulo,
          id: a.id,
          image: a.imageUrl,
          imageUrl: a.imageUrl,
          isFavourite: false);
      _items.add(aa);
      notifyListeners();
    }
  }

  Future search(String query) async {
    // TODO USAR REPOSITORY ...
    const url = 'www.omdbapi.com';
    var params = {'apikey': '9eb7fce9', 's': query, 'type': type, 'r': 'json'};
    var uri = Uri.http(url, '/', params);
    var response = await http.get(uri);
    List<AudiovisualProvider> result = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(response.body);
      if ('True' == body['Response'] && int.parse(body['totalResults']) > 0){
        for (var a in body['Search']) {
          var aa = new AudiovisualProvider(
              title: a['Title'],
              id: a['imdbID'],
              image: a['Poster'],
              imageUrl: a['Poster'],
              isFavourite: false);
          result.add(aa);
        }
      }
    }
    _items = result;
    notifyListeners();
  }
}
