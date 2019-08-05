import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:flutter/material.dart';

class AudiovisualList extends StatefulWidget {
  final String category;
  final String genre;

  AudiovisualList({Key key, this.category, this.genre}) : super(key: key);

  _AudiovisualListState createState() => _AudiovisualListState();
}

class _AudiovisualListState extends State<AudiovisualList> {
  AudiovisualBlock block = AudiovisualBlock();
  final DEFAULT_LIMIT = 50;
  var skipValues = null;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    block.findAudiovisualList(DEFAULT_LIMIT, skipValues, widget.category, widget.genre, null);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: block.audiovisuales,
      builder:
          (BuildContext context, AsyncSnapshot<List<AudiovisualModel>> snapshot) {
        return getAudiovisualCardWidget(snapshot);
      },
    );
  }

  Widget getAudiovisualCardWidget(AsyncSnapshot<List<AudiovisualModel>> snapshot) {
    return new Container(
      child: new Center(
          child: snapshot != null &&
                  snapshot.data != null &&
                  snapshot.data.length != 0
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, itemPosition) {
                    AudiovisualModel audiovisual = snapshot.data[itemPosition];
                    return _buildItem(audiovisual);
                  })
              : Center(
                  child: Text('Cargando'),
                )),
    );
  }

  Widget _buildItem(AudiovisualModel audiovisual) {
    return Container(
      color: Colors.white,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            audiovisual.titulo,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
