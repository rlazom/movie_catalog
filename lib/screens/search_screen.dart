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
            Padding(
              padding: const EdgeInsets.all(20),
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
                      padding: EdgeInsets.all(15),
                      placeholder: 'ej: Back to the Future...',
                      placeholderStyle:
                      TextStyle(color: Colors.white30, fontStyle: FontStyle.italic),
                      suffix: Visibility(
                        visible: _controller.text.isNotEmpty,
                        child: IconButton(
                          icon: Icon(
                            Icons.clear,
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
                      style: ThemeData.dark().textTheme.title,
                      maxLength: 50,
                      decoration: BoxDecoration(
                          color: HexColor('#252525'),
                          borderRadius: BorderRadiusDirectional.circular(20)),
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
                      color: HexColor('#252525'),
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
    if (_query != null && _query.isNotEmpty) {
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
