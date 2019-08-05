import 'package:catalogo/block/block.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AudiovisualList extends StatefulWidget {
  final String category;
  final String genre;

  AudiovisualList({Key key, this.category, this.genre}) : super(key: key);

  _AudiovisualListState createState() => _AudiovisualListState();
}

class _AudiovisualListState extends State<AudiovisualList> {
  AudiovisualBlock block = AudiovisualBlock();
  static const DEFAULT_LIMIT = 20;
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
              getImage(audiovisual),
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

Widget getImage(AudiovisualModel audiovisual) {
  return audiovisual.imageUrl != null
      ? Image.network(
          audiovisual.imageUrl,
          fit: BoxFit.fill,
          height: double.infinity,
        )
      : Container(
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

class AudiovisualDetail extends StatefulWidget {
  final AudiovisualModel audiovisual;

  const AudiovisualDetail({Key key, this.audiovisual}) : super(key: key);

  @override
  _AudiovisualDetailState createState() => _AudiovisualDetailState();
}

class _AudiovisualDetailState extends State<AudiovisualDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
//                    widget.audiovisual.imageUrl != null
//                        ? getImage(widget.audiovisual)
//                        : Image.network(widget.audiovisual.imageUrl),
                    CustomPaint(
                      painter: ShapesPainter(),
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                      ),
                    )
                  ]),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        buildDetailItemTitle(widget.audiovisual.titulo,
                            widget.audiovisual.titulo),

                        ///
                        buildDivider(widget.audiovisual.sinopsis),
                        buildDetailItemContent(widget.audiovisual.sinopsis),

                        ///
                        buildDivider(widget.audiovisual.pais),
                        buildDetailItemTitle('Pais', widget.audiovisual.pais),
                        buildDetailItemContent(widget.audiovisual.pais),

                        ///
                        buildDivider(widget.audiovisual.tamanno),
                        buildDetailItemTitle(
                            'Tamaño', widget.audiovisual.tamanno),
                        buildDetailItemContent(widget.audiovisual.tamanno),

                        ///
                        buildDetailItemTitle(
                            'Formato', widget.audiovisual.formato),
                        buildDivider(widget.audiovisual.formato),
                        buildDetailItemContent(widget.audiovisual.formato),

                        ///
                        buildDetailItemTitle(
                            'Capitulos', widget.audiovisual.capitulos),
                        buildDetailItemContent(widget.audiovisual.capitulos),
                        buildDivider(widget.audiovisual.capitulos),

                        ///
                        buildDetailItemTitle(
                            'Director', widget.audiovisual.director),
                        buildDetailItemContent(widget.audiovisual.director),
                        buildDivider(widget.audiovisual.director),

                        ///
                        buildDetailItemTitle('Año', widget.audiovisual.anno),
                        buildDetailItemContent(widget.audiovisual.anno),
                        buildDivider(widget.audiovisual.anno),

                        ///
                        buildDetailItemTitle(
                            'Productora', widget.audiovisual.productora),
                        buildDetailItemContent(widget.audiovisual.productora),
                        buildDivider(widget.audiovisual.productora),

                        ///
                        buildDetailItemTitle(
                            'Duración', widget.audiovisual.duracion),
                        buildDetailItemContent(widget.audiovisual.duracion),
                        buildDivider(widget.audiovisual.duracion),

                        ///
                        buildDetailItemTitle(
                            'Idioma', widget.audiovisual.idioma),
                        buildDetailItemContent(widget.audiovisual.idioma),
                        buildDivider(widget.audiovisual.idioma),

                        ///
                        buildDetailItemTitle(
                            'Reparto', widget.audiovisual.reparto),
                        buildDetailItemContent(widget.audiovisual.reparto),
                        buildDivider(widget.audiovisual.reparto),
                      ],
                    )),
              )
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              // title: new Text(widget.audiovisual.nombre),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDivider(String value) {
    return Visibility(
      visible: value != null && value.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Divider(
          height: 1,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildDetailItemTitle(String title, String value) {
    return Visibility(
      visible: value != null && value.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildDetailItemContent(String value) {
    return Visibility(
      visible: value != null && value.isNotEmpty,
      child: new Text(
        value,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the paint color to be white
    // paint.color = Colors.white;
    // Create a rectangle with size and width same as the canvas
    // var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // draw the rectangle using the paint
    // canvas.drawRect(rect, paint);
    paint.color = Colors.white;
    // create a path
    var path = Path();
    // path.lineTo(0, 30);
    // path.lineTo(0, size.width / 2);
    // path.lineTo(size.width / 2, 0);
    // path.lineTo(size.width / 2, 30);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width / 2, size.height * 0.9, 0, 0);
    path.close();
    // close the path to form a bounded shape
    path.close();
    canvas.drawPath(path, paint);
    // set the color property of the paint
    // paint.color = Colors.deepOrange;
    // center of the canvas is (x,y) => (width/2, height/2)
    // var center = Offset(size.width / 2, size.height / 2);
    // draw the circle with center having radius 75.0
    // canvas.drawCircle(center, 75.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CurvePainter extends CustomPainter {
  Color colorOne = Colors.red;
  Color colorTwo = Colors.red[300];
  Color colorThree = Colors.red[100];

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
        size.width * 0.17, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
        size.width * 0.50, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    paint.color = colorThree;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorTwo;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
        size.width * 0.22, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
        size.width * 0.40, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
        size.width * 0.65, size.height * 0.70);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
