import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'audiovisual_list_item.dart';

class AudiovisualList extends StatefulWidget {
  final bool isShowingFavs;

  const AudiovisualList({Key key, this.isShowingFavs}) : super(key: key);

  @override
  _AudiovisualListState createState() => _AudiovisualListState();
}

class _AudiovisualListState extends State<AudiovisualList> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
//      Provider.of<AudiovisualListProvider>(context, listen: false)
//          .syncroAudiovisuals(context);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    if (widget.isShowingFavs ?? false) {
      return provider.favs.length > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: provider.favs.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: provider.favs[i], child: AudiovisualListItem()),
            )
          : Container(
              child: Center(
                child: Text('No haz seleccionado ningun favorito'),
              ),
            );
    }
    return provider.items != null && provider.items.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: provider.items.length,
            itemBuilder: (ctx, i) => i < provider.items.length
                ? ChangeNotifierProvider.value(
                    value: provider.items[i], child: AudiovisualListItem())
                : FlatButton(onPressed: () {}, child: Text('More')),
          )
        : Container(
            child: Center(
              child: Icon(
                FontAwesomeIcons.imdb,
                size: 100,
                color: Colors.grey.withOpacity(0.09),
              ),
            ),
          );
  }
}
