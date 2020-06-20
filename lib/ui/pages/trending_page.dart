import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/ui/widgets/audiovisual_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
//    final provider =
//        Provider.of<AudiovisualListProvider>(context, listen: false);
//    provider.getTrendings(context);
    return Container(
      color: Colors.white,
      child: AudiovisualGrid(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
