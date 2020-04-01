import 'package:catalogo/widgets/games_list.dart';

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
        Padding(
          padding: const EdgeInsets.all(20),
          child: CupertinoTextField(
            controller: _controller,
            onChanged: (query) {
              if (query.isNotEmpty) {
                _query = query;
                makeSearch(provider);
              }
            },
            padding: EdgeInsets.all(15),
            placeholder: 'ej: The Witcher 3...',
            focusNode: _searchFocusNode,
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
