import 'package:catalogo/data/moor_database.dart';
import 'package:catalogo/screens/audiovisual_detail_screen.dart';
import 'package:catalogo/screens/categories_overview.dart';
import 'package:catalogo/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/audiovisuales_provider.dart';
import 'providers/categories_provider.dart';
import 'screens/category_detail.dart';
import 'screens/home_screen.dart';

//LoginService service = new LoginService();

//void main() => runApp(Home());
void main() => runApp(HomeImbd());

class HomeImbd extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AudiovisualListProvider()),],
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('main');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CategoriesProvider()),
        Provider<MyDatabase>(
          create: (context) => MyDatabase(),
          dispose: (context, db) => db.close(),
        )
      ],
      child: MaterialApp(
        title: 'Catalogo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.blueAccent,
            fontFamily: 'Dosis'),
        home: HomeScreen(),
        routes: {
          CategoryDetailScreen.routeName: (ctx) => CategoryDetailScreen(),
        },
      ),
    );
  }
}
