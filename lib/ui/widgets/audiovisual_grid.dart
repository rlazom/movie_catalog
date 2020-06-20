import 'package:catalogo/providers/audiovisual_single_provider.dart';
import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/repository/repository_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/audiovisual_grid_item.dart';

class AudiovisualGrid extends StatelessWidget {
  final bool isShowingFavs;

  const AudiovisualGrid({Key key, this.isShowingFavs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    if (isShowingFavs ?? false) {
      return provider.favs.length > 0
          ? getGrid(provider.favs)
          : Container(
              child: Center(
                child: Text('No haz seleccionado ningun favorito'),
              ),
            );
    }
    return FutureBuilder(
      future: getTrending(context),
      builder: (ctx, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return getGrid(snapshot.data);
          case ConnectionState.waiting:
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return Container(
              child: Center(
                child: Text('Algo salio mal!'),
              ),
            );
        }
      },
    );
  }

  GridView getGrid(List<AudiovisualProvider> list) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: list.length,
      itemBuilder: (ctx, i) =>
          ChangeNotifierProvider<AudiovisualProvider>.value(
              value: list[i], child: AudiovisualGridItem()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }

  Future<List<AudiovisualProvider>> getTrending(BuildContext context) {
    var repository = MovieRepository.getInstance(context);
    return repository.getTrending();
  }
}
