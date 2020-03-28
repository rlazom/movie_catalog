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

  Future search(String query, {String type}) async {
    // TODO USAR REPOSITORY ...
    const url = 'www.omdbapi.com';
    var params = {'apikey': '9eb7fce9', 's': query, 'r': 'json'};
    if (type != null && type.isNotEmpty) {
      params = {'apikey': '9eb7fce9', 's': query, 'r': 'json', 'type': type};
    }
    var uri = Uri.http(url, '/', params);
    var response = await http.get(uri);
    List<AudiovisualProvider> result = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if ('True' == body['Response'] && int.parse(body['totalResults']) > 0) {
        for (var a in body['Search']) {
          var aa = new AudiovisualProvider(
              title: a['Title'],
              id: a['imdbID'],
              year: a['Year'],
              type: a['Type'],
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

  Future search2(String query, {String type}) async {
    List<AudiovisualProvider> result = [];
    var body = {
      "Search": [
        {
          "Title": "The Notebook",
          "Year": "2004",
          "imdbID": "tt0332280",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMTk3OTM5Njg5M15BMl5BanBnXkFtZTYwMzA0ODI3._V1_SX300.jpg"
        },
        {
          "Title": "The Notebook",
          "Year": "2013",
          "imdbID": "tt2324384",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMjU1MjYzOTc4NF5BMl5BanBnXkFtZTgwMjEyNTA0MjE@._V1_SX300.jpg"
        },
        {
          "Title": "Sara's Notebook",
          "Year": "2018",
          "imdbID": "tt6599742",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BNzlkNDc0MTQtYzU3NS00ZTdlLTlkOWMtZTI4OWUxYTNiZDM4XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg"
        },
        {
          "Title": "Notebook",
          "Year": "2019",
          "imdbID": "tt9105014",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMTE2N2M3NjEtODhiNy00ZGIwLWI0NzUtYWViN2NhNjhiNjc1XkEyXkFqcGdeQXVyNjE1OTQ0NjA@._V1_SX300.jpg"
        },
        {
          "Title": "Notebook on Cities and Clothes",
          "Year": "1989",
          "imdbID": "tt0096852",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMTY4MzQ0NDQ2Ml5BMl5BanBnXkFtZTYwNDA3MTg5._V1_SX300.jpg"
        },
        {
          "Title": "Notebook",
          "Year": "2006",
          "imdbID": "tt0924260",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BODcwMzYxMDQtZGVlOS00OGI5LWE1ODAtNmJjZjIyOGFmMWU5XkEyXkFqcGdeQXVyMjkxNzQ1NDI@._V1_SX300.jpg"
        },
        {
          "Title": "A Wanderer's Notebook",
          "Year": "1962",
          "imdbID": "tt0056081",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BNTAwZjdkM2EtNzE5Zi00YTJjLWI1NjUtZWFjYTg4YzI4MWMyXkEyXkFqcGdeQXVyNjc0MzE1MDI@._V1_SX300.jpg"
        },
        {
          "Title": "Notebook",
          "Year": "1963",
          "imdbID": "tt0305908",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BZjJiMDgxMzItOTUyZC00NWE5LWFkNmMtMTNhY2JiOWNmOGRlL2ltYWdlXkEyXkFqcGdeQXVyMjYxMzY2NDk@._V1_SX300.jpg"
        },
        {
          "Title": "From the Notebook of...",
          "Year": "2000",
          "imdbID": "tt0297901",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BOGU4ZGMxM2MtZTc3OS00Y2FmLWE5ZDAtYWJjZGM0YjE0OTk2XkEyXkFqcGdeQXVyNzg5OTk2OA@@._V1_SX300.jpg"
        },
        {
          "Title":
              "The Director's Notebook: The Cinematic Sleight of Hand of Christopher Nolan",
          "Year": "2007",
          "imdbID": "tt1035445",
          "Type": "movie",
          "Poster": "N/A"
        }
      ],
      "totalResults": "63",
      "Response": "True"
    };
    if ('True' == body['Response'] && int.parse(body['totalResults']) > 0) {
      for (var a in body['Search']) {
        var aa = new AudiovisualProvider(
            title: a['Title'],
            id: a['imdbID'],
            year: a['Year'],
            type: a['Type'],
            image: a['Poster'],
            imageUrl: a['Poster'],
            isFavourite: false);
        result.add(aa);
      }
    }
    _items = result;
    notifyListeners();
  }
}
