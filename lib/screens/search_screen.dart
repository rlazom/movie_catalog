import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/widgets/audiovisual_grid.dart';
import 'package:catalogo/widgets/audiovisual_list.dart';
import 'package:catalogo/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

  final _controller = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Card(
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          child: Row(
            children: <Widget>[
              Expanded(
                child: CupertinoTextField(
                  controller: _controller,
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      _query = query;
                      makeSearch(provider);
                    }
                  },
                  focusNode: _searchFocusNode,
//                  padding: const EdgeInsets.all(15),
                  placeholder: 'ej: Back to the Future...',
                  placeholderStyle: TextStyle(
                      color: Colors.black38, fontStyle: FontStyle.italic),
                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                  ),
                  prefixMode: OverlayVisibilityMode.notEditing,
                  suffix: Visibility(
                    visible: _controller.text.isNotEmpty,
                    child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black87,
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _controller.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _query = '';
                        });
                      },
                    ),
                  ),
                  style: ThemeData.dark().textTheme.title.copyWith(color: Colors.black87),
//                  cursorColor: Colors.red,
                  maxLength: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent, //HexColor('#252525'),
//                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                ),
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
                  color: _type.isEmpty ? HexColor('#252525') : Theme.of(context).primaryColor,
                  size: 18,
                ),
                itemBuilder: (_) => _types
                    .map((type) => PopupMenuItem(
                          value: type['value'],
                          child: Text(type['label']),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Consumer<AudiovisualListProvider>(
                    builder: (ctx, prov, child) => _showMode == ShowOptions.Grid
                        ? AudiovisualGrid()
                        : AudiovisualList()),
          ),
        ),
      ],
    ));
  }

  void makeSearch(AudiovisualListProvider provider) {
    if (_query != null && _query.isNotEmpty && _query.length > 2) {
      setState(() {
        _isLoading = true;
      });
      provider.search(context, _query, type: _type).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
