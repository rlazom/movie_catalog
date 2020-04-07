import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/providers/games_provider.dart';
import 'package:catalogo/widgets/audiovisual_list.dart';
import 'package:catalogo/widgets/games_list.dart';
import 'package:catalogo/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

enum FAVOURITE_THINGS { FILMS, SERIES, GAMES }

class FavouriteScren extends StatelessWidget {
  static const routeNameFilms = '/film_fav';
  static const routeNameSeries = '/series_fav';
  static const routeNameGames = '/game_fav';
  final FAVOURITE_THINGS param;
  final titles = {
    FAVOURITE_THINGS.FILMS: 'Mis Películas Favoritas',
    FAVOURITE_THINGS.GAMES: 'Mis Juegos Favoritos',
    FAVOURITE_THINGS.SERIES: 'Mis Series Favoritas',
  };
  final types = {
    FAVOURITE_THINGS.FILMS: 'movie',
    FAVOURITE_THINGS.SERIES: 'series'
  };

  FavouriteScren({Key key, @required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent).then((value) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    });
    Widget body;
    switch (param) {
      case FAVOURITE_THINGS.FILMS:
        final provider =
            Provider.of<AudiovisualListProvider>(context, listen: false);
        provider.loadFavorites(context, types[param]);
        body = Consumer<AudiovisualListProvider>(
          builder: (_, provider, child) => AudiovisualList(
            isShowingFavs: true,
          ),
        );
        break;
      case FAVOURITE_THINGS.SERIES:
        final provider =
            Provider.of<AudiovisualListProvider>(context, listen: false);
        provider.loadFavorites(context, types[param]);
        body = Consumer<AudiovisualListProvider>(
          builder: (_, provider, child) => AudiovisualList(
            isShowingFavs: true,
          ),
        );
        break;
      case FAVOURITE_THINGS.GAMES:
        final provider = Provider.of<GameListProvider>(context, listen: false);
        provider.loadFavorites(context);
        body = Consumer<GameListProvider>(
          builder: (_, provider, child) => GameList(
            isShowingFavs: true,
          ),
        );
//        body = SizedBox.expand(
//            child: DraggableScrollableSheet(
//          minChildSize: 0.01,
//          initialChildSize: 0.05,
//          maxChildSize: 1,
//          builder: (_, _controller) => Container(
//              color: HexColor('#252525'),
//              child: ListView.builder(
//                  controller: _controller,
//                  itemCount: 25,
//                  itemBuilder: ((_, i) => i == 0
//                      ? Center(child: Icon(Icons.arrow_drop_up, color: Colors.white,))
//                      : ListTile(
//                          title: Text(i.toString(),
//                              style: Theme.of(context)
//                                  .textTheme
//                                  .title
//                                  .copyWith(color: Colors.white)),
//                        )))),
//        ));
        break;
      default:
        body = Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[param],
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: HexColor('#252525'),
      ),
      body: body,
    );
  }
}
