import 'package:catalogo/providers/audiovisual_single_provider.dart';
import 'package:catalogo/screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudiovisualListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audiovisual =
        Provider.of<AudiovisualProvider>(context, listen: false);

    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(AudiovisualDetail.routeName,
              arguments: audiovisual.id);
        },
//        leading: audiovisual.imageUrl != null
//            ? Image.network(
//                audiovisual.imageUrl,
//                fit: BoxFit.fill,
//              )
//            : backFlipCard(audiovisual),
        trailing: Consumer<AudiovisualProvider>(
            builder: (ctx, product, child) => IconButton(
                icon: product.isFavourite
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () => product.toggleFavourite(),
                color: Theme.of(context).accentColor)),
        title: Text(audiovisual.title,
            style: TextStyle(color: Colors.black87, fontSize: 16)),
      ),
    );
  }
}
