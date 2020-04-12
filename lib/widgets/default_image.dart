import 'package:flutter/material.dart';

import 'hex_color.dart';

class PlaceholderImage extends StatelessWidget {
  final double heigth;
  final Widget child;

  const PlaceholderImage({
    Key key,
    this.heigth, this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: child,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Theme.of(context).primaryColor, Colors.black])),
    );
  }
}