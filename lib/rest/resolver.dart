import 'dart:convert';
import 'package:catalogo/data/moor_database.dart';
import 'package:catalogo/providers/audiovisual_single_provider.dart';
import 'package:catalogo/providers/game_single_provider.dart';
import 'package:http/http.dart' as http;

class RestResolver {
  Future searchMovie(String query, {String type}) async {
    List<AudiovisualProvider> result;
    const url = 'www.omdbapi.com';
    var params = {'apikey': '9eb7fce9', 's': query, 'r': 'json'};
    if (type != null && type.isNotEmpty) {
      params = {'apikey': '9eb7fce9', 's': query, 'r': 'json', 'type': type};
    }
    var uri = Uri.http(url, '/', params);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        result = [];
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
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future searchGames(String query) async {
    List<GameProvider> result;
    const url = 'https://api-v3.igdb.com/games';
    const headers = {'user-key': '26c513d89314b2f280e551a4bbb1eff0'};
    final body = 'fields name; search "$query";';
    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        result = [];
        var body = jsonDecode(response.body);
        for (var a in body) {
          var game = new GameProvider(
              title: a['name'],
              id: a['id'].toString(),
              isFavourite: false);
          result.add(game);
        }
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future findMovieById(String id) async {
    try {
      const url = 'www.omdbapi.com';
      var params = {'apikey': '9eb7fce9', 'i': id, 'r': 'json', 'plot': 'full'};
      var uri = Uri.http(url, '/', params);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
            var result = jsonDecode(response.body);
            var fullData = AudiovisualTableData(
                id: result["imdbID"],
                image: result["Poster"],
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
                category: result["Type"],
                isFavourite: false,
                genre: result["Genre"]);
            return fullData;
          }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future findGameById(String id) async {
    try {
      const url = 'https://api-v3.igdb.com/games';
      const headers = {'user-key': '26c513d89314b2f280e551a4bbb1eff0'};
      final body = 'fields id,franchise.name,cover.image_id,name,rating,created_at,genres.name,platforms.name,summary;where id = $id;';
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
            var result = jsonDecode(response.body);
            //id,franchise.name,cover.url,category,name,rating,created_at,genres.name,platforms.name,summary
            // image
            final Map cover = result[0]["cover"];
            // genre
            final List genres = result[0]["genres"];
            final genre = genres?.map((a) => a["name"])?.join(', ');
            // empresa
            final List empresas = result[0]["franchise"];
            final empresa = empresas?.map((a) => a["name"])?.join(', ');
            // plataformas
            final List plataformas = result[0]["platforms"];
            final platform = plataformas?.map((a) => a["name"])?.join(', ');
            // rating
            final double rating = await result[0]["rating"];
            // anno
            final fechaLanzamiento = new DateTime.fromMillisecondsSinceEpoch((result[0]["created_at"] as int) * 1000);
            var fullData = GameTableData(
                id: result[0]["id"].toString(),
                image: cover != null ? cover["image_id"] : null,
                empresa: empresa,
                plataformas: platform,
                fechaLanzamiento: fechaLanzamiento,
                score: rating?.round()?.toString(),
                sinopsis: result[0]["summary"],
                titulo: result[0]["name"],
                isFavourite: false,
                genre: genre);
            return fullData;
          }
    } catch (e) {
      print(e);
    }
    return null;
  }

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
}