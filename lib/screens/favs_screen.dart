import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/providers/games_provider.dart';
import 'package:catalogo/providers/util.dart';
import 'package:catalogo/widgets/audiovisual_list.dart';
import 'package:catalogo/widgets/games_list.dart';
import 'package:catalogo/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class FavouriteScren extends StatefulWidget {
  static const routeNameFilms = '/film_fav';
  static const routeNameSeries = '/series_fav';
  static const routeNameGames = '/game_fav';
  final FAVOURITE_THINGS param;

  FavouriteScren({Key key, @required this.param}) : super(key: key);

  @override
  _FavouriteScrenState createState() => _FavouriteScrenState();
}

class _FavouriteScrenState extends State<FavouriteScren>
    with WidgetsBindingObserver {
  final titles = {
    FAVOURITE_THINGS.FILMS: 'Películas',
    FAVOURITE_THINGS.GAMES: 'Juegos',
    FAVOURITE_THINGS.SERIES: 'Series',
  };

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent).then((value) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent).then((value) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (widget.param) {
      case FAVOURITE_THINGS.FILMS:
        final provider =
            Provider.of<AudiovisualListProvider>(context, listen: false);
        provider.loadFavorites(context, type: FAVOURITE_THINGS.FILMS);
        body = Consumer<AudiovisualListProvider>(
          builder: (_, provider, child) => AudiovisualList(
            isShowingFavs: true,
          ),
        );
        break;
      case FAVOURITE_THINGS.FILMS:
        final provider =
            Provider.of<AudiovisualListProvider>(context, listen: false);
        provider.loadFavorites(context, type: FAVOURITE_THINGS.FILMS);
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
          titles[widget.param],
        ),
        backgroundColor: Colors.white,
        elevation: 5,
//        backgroundColor: HexColor('#252525'),
      ),
      body: body,
    );
  }
}
