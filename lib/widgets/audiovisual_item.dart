import 'package:catalogo/providers/audiovisual_single_provider.dart';
import 'package:catalogo/screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudiovisualGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audiovisual =
        Provider.of<AudiovisualProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AudiovisualDetail.routeName,
                arguments: audiovisual.id);
          },
          splashColor: Colors.white,
          child: audiovisual.imageUrl != null
              ? Image.network(
                  audiovisual.imageUrl,
                  fit: BoxFit.fill,
                )
              : backFlipCard(audiovisual),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            trailing: Consumer<AudiovisualProvider>(
                builder: (ctx, product, child) => IconButton(
                    icon: product.isFavourite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                    onPressed: () => product.toggleFavourite(),
                    color: Theme.of(context).accentColor)),
            title: audiovisual.imageUrl != null
                ? Text(
                    audiovisual.title,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                : Container()),
      ),
    );
  }

  Widget backFlipCard(AudiovisualProvider audiovisual) {
    Widget back = Container(
      color: Colors.black,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              audiovisual.title,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Container(
              height: 10,
            ),
//            IconButton(
//              icon: Icon(FontAwesomeIcons.infoCircle),
//              color: Colors.white,
//              iconSize: 40,
//              onPressed: () => /*_navigateToDetails(audiovisual, context)*/ {},
//            )
            // Text(
            //   'Ver mas...',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.grey,
            //   ),
            // )
          ],
        ),
      ),
    );
    return back;
  }
}
