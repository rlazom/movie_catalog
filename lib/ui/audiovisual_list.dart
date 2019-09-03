import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/model/category/CategoryModel.dart';
import 'package:catalogo/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'audiovisual_detail.dart';

class AudiovisualList extends StatelessWidget {
//  final String category;
//  final String genre;
//
//  AudiovisualList({Key key, this.category, this.genre}) : super(key: key);
//
//  _AudiovisualListState createState() => _AudiovisualListState();
//}
//
//class _AudiovisualListState extends State<AudiovisualList> {
  final AudiovisualBlock block = AudiovisualBlock();
  final DEFAULT_LIMIT = 20;
  final skipValues = null;

//  @override
//  void initState() {
//    super.initState();
//    loadData();
//  }

  void loadData(CategoryModel category, CategoryModel genre) {
    block.findAudiovisualList(
        DEFAULT_LIMIT, skipValues, category.id, genre.id, null);
  }

  @override
  Widget build(BuildContext context) {
    var parentCategory = MyInheritedWidget.of(context).myCategory;
    var parentGenre = MyInheritedWidget.of(context).myGenre;
    loadData(parentCategory, parentGenre);
    return StreamBuilder(
      stream: block.audiovisuales,
      builder: (BuildContext context,
          AsyncSnapshot<List<AudiovisualModel>> snapshot) {
        return getAudiovisualCardWidget(context, snapshot);
      },
    );
  }

  Widget getAudiovisualCardWidget(
      BuildContext context, AsyncSnapshot<List<AudiovisualModel>> snapshot) {
    return new Container(
      child: new Center(
          child: snapshot != null &&
                  snapshot.connectionState != ConnectionState.waiting
              ? snapshot != null &&
                      snapshot.data != null &&
                      snapshot.data.length != 0
                  ? _buildGrid(context, snapshot)
                  : Text('Sin resultados')
              : Center(
                  child: Text('Cargando'),
                )),
    );
  }

  Widget _buildGrid(
      BuildContext context, AsyncSnapshot<List<AudiovisualModel>> snapshot) {
    int columns = (MediaQuery.of(context).size.width ~/ 128);
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, childAspectRatio: 0.7),
        itemCount: snapshot.data.length,
        itemBuilder: (context, itemPosition) {
          AudiovisualModel audiovisual = snapshot.data[itemPosition];
          return _buildItem(audiovisual, context);
        });
  }

  Widget _buildItem(AudiovisualModel audiovisual, BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () => _navigateToDetails(audiovisual, context),
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

  void _navigateToDetails(
      AudiovisualModel audiovisual, BuildContext context) {
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
