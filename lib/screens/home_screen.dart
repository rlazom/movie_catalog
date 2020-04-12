import 'package:catalogo/widgets/hex_color.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/search_games_page.dart';
import '../widgets/search_movie_page.dart';
import '../widgets/user_page.dart';

class ImbdScreen extends StatefulWidget {
  @override
  _ImbdScreenState createState() => _ImbdScreenState();
}

class _ImbdScreenState extends State<ImbdScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final _pages = <Widget>[
//    ColorsPalette(),
    SearchScreen(),
    SearchGameScreen(),
    UserScreen(),
  ];
  TabController _controller;

  @override
  void initState() {
    _controller =
        TabController(length: _pages.length, vsync: this, initialIndex: 0);
    _controller
        .addListener(() => FocusScope.of(context).requestFocus(FocusNode()));
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent).then((value) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
    final _onTap = (i) {
      _controller.animateTo(i);
    };
    final fancy = FancyBottomNavigation(
      tabs: [
//        TabData(iconData: FontAwesomeIcons.trophy, title: "Popular"),
        TabData(iconData: FontAwesomeIcons.film, title: "Media"),
        TabData(iconData: FontAwesomeIcons.gamepad, title: "Juegos"),
        TabData(iconData: FontAwesomeIcons.userAlt, title: "Favoritos")
      ],
      onTabChangedListener: _onTap,
      barBackgroundColor: HexColor('#252525'),
      textColor: Colors.white,
      initialSelection: 0,
      circleColor: Colors.white,
      activeIconColor: Colors.black87,
    );

    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: TabBarView(
          children: _pages,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
        ),
      ),
      bottomNavigationBar: fancy,
    );
  }
}
