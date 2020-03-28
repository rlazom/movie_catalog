import 'dart:convert';

import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/audiovisual/genre.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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

  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  Future findMyData() async {
    const url = 'www.omdbapi.com';
    var params = {'apikey': '9eb7fce9', 'i': id, 'r': 'json', 'plot': 'full'};
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
          sinopsis: await translate(result["Plot"]),
          titulo: result["Title"],
          genre: Genre.fromJsonMap({"categoria": result["Genre"]}));
      return fullData;
    }
    return null;
  }

  // TODO Mover para el repository
  Future translate(String text) async {
    const url = 'translate.googleapis.com';
    var params = {'client': 'gtx', 'sl': 'auto', 'tl': 'es', 'dt': 't', 'q': text};
    var uri = Uri.https(url, '/translate_a/single', params);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      String resultText = '';
      for (var s in result[0]){
        resultText += s[0];
      }
      return resultText;
    }
    return null;
  }

  Future findMyData2() async {
    var result = {
      "Title": "The Notebook",
      "Year": "2004",
      "Rated": "PG-13",
      "Released": "25 Jun 2004",
      "Runtime": "123 min",
      "Genre": "Drama, Romance",
      "Director": "Nick Cassavetes",
      "Writer":
          "Jeremy Leven (screenplay), Jan Sardi (adaptation), Nicholas Sparks (novel)",
      "Actors": "Tim Ivey, Gena Rowlands, Starletta DuPois, James Garner",
      "Plot":
          "In a nursing home, resident Duke reads a romance story for an old woman who has senile dementia with memory loss. In the late 1930s, wealthy seventeen year-old Allie Hamilton is spending summer vacation in Seabrook. Local worker Noah Calhoun meets Allie at a carnival and they soon fall in love with each other. One day, Noah brings Allie to an ancient house that he dreams of buying and restoring and they attempt to make love but get interrupted by their friend. Allie's parents do not approve of their romance since Noah belongs to another social class, and they move to New York with her. Noah writes 365 letters (A Year) to Allie, but her mother Anne Hamilton does not deliver them to her daughter. Three years later, the United States joins the World War II and Noah and his best friend Fin enlist in the army, and Allie works as an army nurse. She meets injured soldier Lon Hammond in the hospital. After the war, they meet each other again going on dates and then, Lon, who is wealthy and handsome, proposes. Meanwhile Noah buys and restores the old house and many people want to buy it. When Allie accidentally sees the photo of Noah and his house in a newspaper, she feels divided between her first love and her commitment with Lon. Meanwhile Duke stops reading to the old lady since his children are visiting him in the nursing home.",
      "Language": "English",
      "Country": "USA",
      "Awards": "12 wins & 10 nominations.",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BMTk3OTM5Njg5M15BMl5BanBnXkFtZTYwMzA0ODI3._V1_SX300.jpg",
      "Ratings": [
        {"Source": "Internet Movie Database", "Value": "7.8/10"},
        {"Source": "Rotten Tomatoes", "Value": "53%"},
        {"Source": "Metacritic", "Value": "53/100"}
      ],
      "Metascore": "53",
      "imdbRating": "7.8",
      "imdbVotes": "492,343",
      "imdbID": "tt0332280",
      "Type": "movie",
      "DVD": "08 Feb 2005",
      "BoxOffice": "81,000,000",
      "Production": "New Line Cinema",
      "Website": "N/A",
      "Response": "True"
    };
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
        score: result["imdbRating"],
        reparto: result["Actors"],
        sinopsis: await translate(result["Plot"]),
        titulo: result["Title"],
        genre: Genre.fromJsonMap({"categoria": result["Genre"]}));
    return fullData;
  }
}
