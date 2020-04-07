import 'package:catalogo/screens/favs_screen.dart';
import 'package:catalogo/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              trailing: Icon(FontAwesomeIcons.film),
                              title: Text(
                                'Mis Películas Favoritas',
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
                              trailing: Icon(FontAwesomeIcons.video),
                              title: Text(
                                'Mis Series Favoritas',
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
                              trailing: Icon(FontAwesomeIcons.gamepad),
                              onTap: () => Navigator.of(context)
                                  .pushNamed(FavouriteScren.routeNameGames)
                                  .then((_) {
                                onBackFromFavsScreen(context);
                              }),
                              title: Text(
                                'Mis Juegos Favoritos',
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
