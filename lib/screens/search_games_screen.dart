import 'package:catalogo/widgets/games_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/games_provider.dart';
import '../widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum ShowOptions { Grid, List }

class SearchGameScreen extends StatefulWidget {
  static const routeName = '/searchGame';

  @override
  _SearchGameScreenState createState() => _SearchGameScreenState();
}

class _SearchGameScreenState extends State<SearchGameScreen>
    with AutomaticKeepAliveClientMixin {
  var _isLoading = false;
  ShowOptions _showMode = ShowOptions.List;
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
        Provider.of<GameListProvider>(context, listen: false);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Card(
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          child: CupertinoTextField(
            controller: _controller,
            onChanged: (query) {
              if (query.isNotEmpty) {
                _query = query;
                makeSearch(provider);
              }
            },
            padding: const EdgeInsets.all(8),
            placeholder: 'ej: The Witcher 3...',
            focusNode: _searchFocusNode,
            prefix: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                color: Colors.black87,
              ),
            ),
            prefixMode: OverlayVisibilityMode.notEditing,
            placeholderStyle:
                TextStyle(color: Colors.black38, fontStyle: FontStyle.italic),
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
            style: ThemeData.light().textTheme.title,
            maxLength: 50,
            decoration: BoxDecoration(
                color: HexColor('#000'),
                borderRadius: BorderRadiusDirectional.circular(20)),
          ),
        ),
        Expanded(
          child: Container(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Consumer<GameListProvider>(
                    builder: (ctx, prov, child) => GameList()),
          ),
        ),
      ],
    ));
  }

  void makeSearch(GameListProvider provider) {
    if (_query != null && _query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      provider.search(context, _query).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
