import 'data/moor_database.dart';
import 'screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/audiovisuales_provider.dart';
import 'providers/games_provider.dart';
import 'screens/home_screen.dart';

//LoginService service = new LoginService();

//void main() => runApp(Home());
void main() => runApp(HomeImbd());

class HomeImbd extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        title: 'Imbd',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.amberAccent,
            fontFamily: 'Dosis'),
        themeMode: ThemeMode.dark,
        home: ImbdScreen(),
        routes: {AudiovisualDetail.routeName: (ctx) => AudiovisualDetail()},
      ),
    );
  }
}
