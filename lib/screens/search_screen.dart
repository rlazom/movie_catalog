import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/widgets/audiovisual_grid.dart';
import 'package:catalogo/widgets/audiovisual_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

enum ShowOptions { Grid, List }

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  var _isLoading = false;
  ShowOptions _showMode = ShowOptions.List;
  final appBarController = AppBarController();

  @override
  void dispose() {
    appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final types = [
      //movie, series, episode
      {'label': 'Peliculas', 'value': 'movie'},
      {'label': 'Series', 'value': 'series'},
      {'label': 'Programas de TV', 'value': 'episode'}
    ];
    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    return Scaffold(
        appBar: SearchAppBar(
            primary: Colors.black87,
            mainAppBar: AppBar(
              backgroundColor: Colors.black87,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                  ),
//                  child: Text(
//                    'BUSCAR',
//                    style: Theme.of(context)
//                        .textTheme
//                        .title
//                        .copyWith(color: Colors.white),
//                  ),
                  onPressed: () => appBarController.stream.add(true),
                ),
                PopupMenuButton(
                  onSelected: (ShowOptions selectedValue) {
                    setState(() {
                      _showMode = selectedValue;
                    });
                  },
                  initialValue: _showMode,
                  tooltip: 'Vista',
                  color: Colors.white,
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text(
                        'Mosaico',
                      ),
                      textStyle: TextStyle(
                          color: _showMode == ShowOptions.Grid
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.title.color),
                      value: ShowOptions.Grid,
                    ),
                    PopupMenuItem(
                      child: Text('Lista'),
                      textStyle: TextStyle(
                          color: _showMode == ShowOptions.List
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.title.color),
                      value: ShowOptions.List,
                    )
                  ],
                )
              ],
            ),
            appBarController: appBarController,
            searchHint: 'Back to the future...',
            onChange: (query) {
              if (query.isNotEmpty) {
                setState(() {
                  _isLoading = true;
                });
                provider.search(query).then((_) {
                  setState(() {
                    _isLoading = false;
                  });
                });
              }
            }),
        body: Container(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Consumer<AudiovisualListProvider>(
                  builder: (ctx, prov, child) => _showMode == ShowOptions.Grid
                      ? AudiovisualGrid()
                      : AudiovisualList()),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
