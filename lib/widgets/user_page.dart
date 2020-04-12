import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/providers/games_provider.dart';
import 'package:catalogo/screens/favs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avProvider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    avProvider.calculateCountFavorites(context);
    final gameProvider = Provider.of<GameListProvider>(context, listen: false);
    gameProvider.calculateCountFavorites(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: OrientationBuilder(
        builder: (_, orientation) {
          switch (orientation) {
            case Orientation.portrait:
              return Column(
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.only(
                        top: 20.0, right: 20.0, left: 20.0),
                    elevation: 20.0,
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: CircleAvatar(
                      radius: 63,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            'assets/images/ic_launcher.png',
                          )),
                    ),
                  ),
                  Expanded(
//                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: <Widget>[
                          Material(
//                            color: Colors.white,
                            child: ListTile(
                              trailing: Consumer<AudiovisualListProvider>(
                                  builder: (__, provider, _) => Text(
                                        provider.moviesFavsCount.toString(),
                                        style:
                                            Theme.of(context).textTheme.title,
                                      )),
                              title: Text(
                                'Películas',
                                style: Theme.of(context).textTheme.title,
                              ),
                              onTap: () => Navigator.of(context)
                                  .pushNamed(FavouriteScren.routeNameFilms)
                                  .then((_) {
                                onBackFromFavsScreen(context);
                              }),
                            ),
                          ),
                          Divider(
                            color: Colors.black54,
                          ),
                          Material(
//                            color: Colors.white,
                            child: ListTile(
                              trailing: Consumer<AudiovisualListProvider>(
                                  builder: (__, provider, _) => Text(
                                        provider.seriesFavsCount.toString(),
                                        style:
                                            Theme.of(context).textTheme.title,
                                      )),
                              title: Text(
                                'Series',
                                style: Theme.of(context).textTheme.title,
                              ),
                              onTap: () => Navigator.of(context)
                                  .pushNamed(FavouriteScren.routeNameSeries)
                                  .then((_) {
                                onBackFromFavsScreen(context);
                              }),
                            ),
                          ),
                          Divider(
                            color: Colors.black54,
                          ),
                          Material(
//                            color: Colors.white,
                            child: ListTile(
                              trailing: Consumer<GameListProvider>(
                                  builder: (__, provider, _) => Text(
                                        provider.favsCount.toString(),
                                        style:
                                            Theme.of(context).textTheme.title,
                                      )),
                              onTap: () => Navigator.of(context)
                                  .pushNamed(FavouriteScren.routeNameGames)
                                  .then((_) {
                                onBackFromFavsScreen(context);
                              }),
                              title: Text(
                                'Juegos',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
              break;
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }

  void onBackFromFavsScreen(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent).then((value) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    });
  }
}
