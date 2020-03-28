import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/widgets/audiovisual_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AudiovisualGrid extends StatefulWidget {
  @override
  _AudiovisualGridState createState() => _AudiovisualGridState();
}

class _AudiovisualGridState extends State<AudiovisualGrid> {
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
    final provider = Provider.of<AudiovisualListProvider>(context, listen: false);
    return provider.items.length > 0
        ? GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: provider.items.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: provider.items[i], child: AudiovisualGridItem()),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
          )
        : Container(
            child: Center(
              child: Icon(
                FontAwesomeIcons.videoSlash,
                size: 100,
                color: Colors.grey.withOpacity(0.20),
              ),
            ),
          );
  }
}
