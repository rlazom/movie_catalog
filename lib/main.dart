import 'data/moor_database.dart';
import 'providers/util.dart';
import 'screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/audiovisuales_provider.dart';
import 'providers/games_provider.dart';
import 'screens/home_screen.dart';

import 'screens/favs_screen.dart';

//LoginService service = new LoginService();

//void main() => runApp(Home());
void main() => runApp(HomeImbd());

class HomeImbd extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    if (useWhiteForeground(Colors.green[400])) {
//      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
//    } else {
//      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
//    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AudiovisualListProvider()),
        ChangeNotifierProvider.value(value: GameListProvider()),
        Provider<MyDatabase>(
          create: (context) => MyDatabase(),
          dispose: (context, db) => db.close(),
        )
      ],
      child: MaterialApp(
        title: 'Catalogo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.amberAccent,
            fontFamily: 'Dosis'),
        themeMode: ThemeMode.dark,
        home: ImbdScreen(),
        routes: {
          AudiovisualDetail.routeName: (ctx) => AudiovisualDetail(),
          FavouriteScren.routeNameFilms: (ctx) => FavouriteScren(
                param: FAVOURITE_THINGS.FILMS,
              ),
          FavouriteScren.routeNameGames: (ctx) => FavouriteScren(
                param: FAVOURITE_THINGS.GAMES,
              ),
          FavouriteScren.routeNameSeries: (ctx) => FavouriteScren(
                param: FAVOURITE_THINGS.SERIES,
              ),
        },
      ),
    );
  }
}
