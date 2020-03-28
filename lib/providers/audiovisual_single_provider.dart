import 'dart:convert';

import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/audiovisual/genre.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AudiovisualProvider with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String imageUrl;
  bool isFavourite;

  AudiovisualProvider(
      {@required this.id,
      @required this.title,
      @required this.image,
      @required this.imageUrl,
      this.isFavourite});

  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  Future findMyData() async {
    const url = 'www.omdbapi.com';
    var params = {'apikey': '9eb7fce9', 'i': id, 'r': 'json'};
    var uri = Uri.http(url, '/', params);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      var fullData = AudiovisualModel.build(
          id: result["imdbID"],
          imageUrl: result["Poster"],
          anno: result["Year"],
          capitulos: result["Episodes"],
          director: result["Director"],
          duracion: result["Runtime"],
          productora: result["Production"],
          idioma: result["Language"],
          pais: result["Country"],
          reparto: result["Actors"],
          sinopsis: result["Plot"],
          titulo: result["Title"],
          genre: Genre.fromJsonMap({"categoria": result["Genre"]}));
      return fullData;
    }
    return null;
  }
}
