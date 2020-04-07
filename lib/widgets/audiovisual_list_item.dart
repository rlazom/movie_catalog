import 'package:catalogo/providers/audiovisual_single_provider.dart';
import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudiovisualListItem extends StatelessWidget {
  final _types = {
    'movie': 'Película',
    'series': 'Serie',
    'episode': 'Programa de TV'
  };

  @override
  Widget build(BuildContext context) {
    final audiovisual =
        Provider.of<AudiovisualProvider>(context, listen: false);
    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);

    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
//          Navigator.of(context).pushNamed(AudiovisualDetail.routeName,
//              arguments: audiovisual.id);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                  value: audiovisual, child: AudiovisualDetail())))
          .then((_) => provider.loadFavorites(context, audiovisual.type));
        },
//        leading: audiovisual.imageUrl != null
//            ? Image.network(
//                audiovisual.imageUrl,
//                fit: BoxFit.fill,
//              )
//            : backFlipCard(audiovisual),
//        trailing: Consumer<AudiovisualProvider>(
//            builder: (ctx, product, child) => IconButton(
//                icon: product.isFavourite
//                    ? Icon(Icons.favorite, color: Colors.red)
//                    : Icon(Icons.favorite_border, color: Colors.red),
//                onPressed: () => product.toggleFavourite(),
//                color: Theme.of(context).accentColor)),
        title:
            Text(audiovisual.title, style: Theme.of(context).textTheme.title),
        subtitle: Text('${_types[audiovisual.type]}/${audiovisual.year}',
            style: Theme.of(context).textTheme.subtitle),
      ),
    );
  }
}
