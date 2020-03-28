import 'package:flutter/material.dart';

class DefaultAudiovisualImage extends StatelessWidget {
  final double heigth;

  const DefaultAudiovisualImage({
    Key key,
    this.heigth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey, Colors.black54, Colors.black])),
    );
  }
}