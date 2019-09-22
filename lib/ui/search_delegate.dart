import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/ui/audiovisual_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AudiovisualSearchDelegate extends SearchDelegate {
  final AudiovisualBlock block = AudiovisualBlock();
  var limit = 20;
  var category;
  var genre;
  var skip = 0;

  AudiovisualSearchDelegate({this.category, this.genre});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          FontAwesomeIcons.eraser,
          size: 20,
        ),
        onPressed: () {
          query = '';
        },
      ),
      // IconButton(
      //   icon: Icon(
      //     FontAwesomeIcons.filter,
      //     size: 20,
      //   ),
      //   onPressed: () {
      //     query = '';
      //   },
      // )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildItemsList(context);
  }

  Widget buildListTile(dynamic result, BuildContext context) {
    if (result is AudiovisualModel) {
      int startIndex = 0;
      if (query != null && query.length > 0) {
        var indexOf = result.titulo.toLowerCase().indexOf(query.toLowerCase());
        startIndex = indexOf > -1 ? indexOf : 0;
      }
      return Card(
        elevation: 5,
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                  text: result.titulo
                      .substring(0, startIndex > 0 ? startIndex : 0),
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: result.titulo
                            .substring(startIndex, startIndex + query.length),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            result.titulo.substring(startIndex + query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
            subtitle: Text(
                '${result.category.categoria} / ${result.genre.categoria}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AudiovisualDetail(
                            audiovisual: result,
                          )));
            },
          ),
        ),
      );
    } else
      return ListTile(
        title: Text('Wrong Data'),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildItemsList(context);
  }

  StreamBuilder<List<dynamic>> buildItemsList(BuildContext context) {
    block.findAudiovisualList(limit, 0, category, genre, query);

    return StreamBuilder(
      stream: block.audiovisuales,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Container(child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.data.length == 0) {
          return Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.frownOpen,
                    color: Colors.black.withOpacity(0.1),
                    size: 100,
                  ),
                  Container(height: 20,),
                  Text('Nada...')
                ],
              ),
            ),
          );
        } else {
          var results = snapshot.data;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              var result = results[index];
              return buildListTile(result, context);
            },
          );
        }
      },
    );
  }
}
