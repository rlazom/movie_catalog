import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ZoomImage extends StatelessWidget {
  final String imageUrl;

  const ZoomImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: w,
                  height: h * 0.8,
                  fit: BoxFit.fill,
                ),
              )),
//          Container(
//              color: Colors.black,
//              child: Center(
//                  child: Image.network(
//                imageUrl,
//                width: w,
//                height: h * 0.8,
//                fit: BoxFit.fill,
//              ))),
          SizedBox(
              height: 80,
              child: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white),
              )),
        ],
      ),
    );
  }
}