import 'package:catalogo/repository/repository_games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game_single_provider.dart';

class GameListProvider with ChangeNotifier {

  List<GameProvider> _items = [];

  List<GameProvider> get items {
    return [..._items];
  }

  GameProvider findById(String id) {
    return _items.firstWhere((av) => av.id == id);
  }

  Future search(BuildContext context, String query, {String type}) async {
//    return search2(query);
    final GamesRepository _repository = GamesRepository(context);
    final result = await _repository.search(query, type: type);
    if (result != null) {
      _items = result;
    } else
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('No Conection!!!'),
              ));
    notifyListeners();
  }

  Future search2(String query, {String type}) async {
    List<GameProvider> result = [];
    var body = [
      {
        "id": 2946,
        "name": "FIFA 12",
      },
      {
        "id": 701,
        "name": "FIFA Football 2002",
      },
      {
        "id": 2153,
        "name": "FIFA 13",
      },
      {
        "id": 71398,
        "name": "FIFA Soccer 97",
      },
      {
        "id": 703,
        "name": "FIFA Football 2005",
      },
      {
        "id": 3135,
        "name": "FIFA 08",
      },
      {
        "id": 696,
        "name": "FIFA 07",
      },
      {
        "id": 126294,
        "name": "FIFA 2000",
      },
      {
        "id": 103733,
        "name": "FIFA Soccer: FIFA World Cup",
      },
      {
        "id": 22342,
        "name": "FIFA 06: Road to FIFA World Cup",
      }
    ];
    for (var a in body) {
      var game = new GameProvider(
          title: a['name'],
          id: a['id'].toString(),
          isFavourite: false);
      result.add(game);
    }
    _items = result;
    notifyListeners();
  }
}
