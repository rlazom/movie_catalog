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
  final _types = [
    //movie, series, episode
    {'label': 'Películas', 'value': 'movie'},
    {'label': 'Series', 'value': 'series'},
    {'label': 'Todos', 'value': ''}
  ];
  String _type = '';
  String _query = '';

  final appBarController = AppBarController();

  @override
  void dispose() {
    appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    return Scaffold(
        appBar: SearchAppBar(
            primary: Colors.black87,
            mainAppBar: AppBar(
              backgroundColor: Colors.black87,
              title: GestureDetector(
                onTap: () => appBarController.stream.add(true),
                child: Text(
                  _query,
                  style:
                      TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                  ),
                  onPressed: () => appBarController.stream.add(true),
                ),
                PopupMenuButton(
                  onSelected: (String selectedValue) {
                    setState(() {
                      _type = selectedValue;
                    });
                    makeSearch(provider);
                  },
                  initialValue: _type,
                  tooltip: 'Filtros',
                  color: Colors.white,
                  icon: Icon(
                    FontAwesomeIcons.filter,
                    color: Colors.white,
                  ),
                  itemBuilder: (_) => _types
                      .map((type) => PopupMenuItem(
                            value: type['value'],
                            child: Text(type['label']),
                          ))
                      .toList(),
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
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text(
                        'Mosaico',
                      ),
                      value: ShowOptions.Grid,
                    ),
                    PopupMenuItem(
                      child: Text('Lista'),
                      value: ShowOptions.List,
                    ),
                  ],
                )
              ],
            ),
            appBarController: appBarController,
            searchHint: 'Back to the future...',
            onChange: (query) {
              if (query.isNotEmpty) {
                _query = query;
                makeSearch(provider);
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

  void makeSearch(AudiovisualListProvider provider) {
    if (_query != null && _query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      provider.search(_query, type: _type).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
