import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'audiovisual_detail.dart';

class AudiovisualList extends StatefulWidget {
  final String category;
  final String genre;

  AudiovisualList({Key key, this.category, this.genre}) : super(key: key);

  _AudiovisualListState createState() => _AudiovisualListState();
}

class _AudiovisualListState extends State<AudiovisualList> {
  AudiovisualBlock block = AudiovisualBlock();
  static const DEFAULT_LIMIT = 10;
  var skipValues = null;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    block.findAudiovisualList(
        DEFAULT_LIMIT, skipValues, widget.category, widget.genre, null);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: block.audiovisuales,
      builder: (BuildContext context,
          AsyncSnapshot<List<AudiovisualModel>> snapshot) {
        return getAudiovisualCardWidget(snapshot);
      },
    );
  }

  Widget getAudiovisualCardWidget(
      AsyncSnapshot<List<AudiovisualModel>> snapshot) {
    return new Container(
      child: new Center(
          child: snapshot != null && snapshot.data != null
              ? snapshot.data.length != 0
                  ? _buildGrid(snapshot)
//                  ? _buildList(snapshot)
                  : Text('Sin resultados')
              : Center(
                  child: Text('Cargando'),
                )),
    );
  }

  Widget _buildList(AsyncSnapshot<List<AudiovisualModel>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, itemPosition) {
          AudiovisualModel audiovisual = snapshot.data[itemPosition];
          return _buildItem(audiovisual);
        });
  }

  Widget _buildGrid(AsyncSnapshot<List<AudiovisualModel>> snapshot) {
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        itemCount: snapshot.data.length,
        itemBuilder: (context, itemPosition) {
          AudiovisualModel audiovisual = snapshot.data[itemPosition];
          return _buildItem(audiovisual);
        });
  }

  Widget _buildItem(AudiovisualModel audiovisual) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () => _navigateToDetails(audiovisual),
        child: Card(
          margin: EdgeInsets.all(10),
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          elevation: 5,
          clipBehavior: Clip.hardEdge,
          child: (new Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              audiovisual.imageUrl != null
                  ? Image.network(
                      audiovisual.imageUrl,
                      fit: BoxFit.fill,
                      height: double.infinity,
                    )
                  : new DefaultAudiovisualImage(),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.black54,
                      Colors.black87
                    ])),
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text(
                  audiovisual.titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  void _navigateToDetails(AudiovisualModel audiovisual) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AudiovisualDetail(
                  audiovisual: audiovisual,
                )));
  }
}

class DefaultAudiovisualImage extends StatelessWidget {
  final double heigth;
  const DefaultAudiovisualImage({
    Key key,
    this.heigth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey, Colors.black54, Colors.black])),
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.grey,
          size: 100,
        ),
      ),
    );
  }
}

// Widget getImage(AudiovisualModel audiovisual) {
//   return audiovisual.imageUrl != null
//       ? Image.network(
//           audiovisual.imageUrl,
//           fit: BoxFit.fill,
//           height: double.infinity,
//         )
//       : Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Colors.grey, Colors.black54, Colors.black])),
//           child: Center(
//             child: Icon(
//               Icons.image,
//               color: Colors.grey,
//               size: 100,
//             ),
//           ),
//         );
// }
