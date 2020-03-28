import 'package:catalogo/screens/search_screen.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ImbdScreen extends StatefulWidget {
  @override
  _ImbdScreenState createState() => _ImbdScreenState();
}

class _ImbdScreenState extends State<ImbdScreen>
    with SingleTickerProviderStateMixin {
  final _pages = <Widget>[
    Center(
      child: Text('HOME'),
    ),
    SearchScreen(),
    Center(
      child: Text('ACCOUNT'),
    ),
  ];
  TabController _controller;

  @override
  void initState() {
    _controller =
        TabController(length: _pages.length, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _onTap = (i) {
      _controller.animateTo(i);
    };
    final fancy = FancyBottomNavigation(
      tabs: [
        TabData(iconData: FontAwesomeIcons.trophy, title: "Popular"),
        TabData(iconData: FontAwesomeIcons.search, title: "Search"),
        TabData(iconData: FontAwesomeIcons.cog, title: "Settings")
      ],
      onTabChangedListener: _onTap,
      barBackgroundColor: Colors.black87,
      textColor: Colors.white,
      initialSelection: 1,
      activeIconColor: Colors.black87,
    );

    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: TabBarView(
          children: _pages,
          controller: _controller,
        ),
      ),
      bottomNavigationBar: fancy,
    );
  }
}
