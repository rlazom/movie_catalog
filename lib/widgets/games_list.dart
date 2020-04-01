import '../providers/games_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'games_list_item.dart';

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
//      Provider.of<GameListProvider>(context, listen: false)
//          .syncroGames(context);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameListProvider>(context, listen: false);
    return provider.items.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: provider.items.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: provider.items[i], child: GameListItem()),
          )
        : Container(
            child: Center(
              child: Icon(
                FontAwesomeIcons.imdb,
                size: 100,
                color: Colors.grey.withOpacity(0.09),
              ),
            ),
          );
  }
}
