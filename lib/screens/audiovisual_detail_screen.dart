import 'dart:ui' as prefix0;
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/providers/audiovisual_single_provider.dart';
import 'package:catalogo/providers/audiovisuales_provider.dart';
import 'package:catalogo/widgets/default_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AudiovisualDetail extends StatefulWidget {
  static const routeName = '/audiovisualDetail';

  @override
  _AudiovisualDetailState createState() => _AudiovisualDetailState();
}

class _AudiovisualDetailState extends State<AudiovisualDetail> {
  var _isLoading = true;
  AudiovisualModel _audiovisual;

  @override
  void didChangeDependencies() {
    final id = ModalRoute.of(context).settings.arguments as String; //id
    final audiovisualProvider =
        Provider.of<AudiovisualListProvider>(context, listen: false)
            .findById(id);
    audiovisualProvider.findMyData().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _audiovisual = value;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
          body: Container(
              child:
                  Center(child: SizedBox(child: CircularProgressIndicator()))));
    }
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverSafeArea(
                top: false,
                sliver: getAppBar(context),
              ),
            )
          ];
        },
        body: Container(
          color: Colors.black.withAlpha(32),
          child: CustomScrollView(
            slivers: <Widget>[getContent()],
          ),
        ),
      ),
    );
  }

  SliverPadding getContent() {
    return SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(buildAudiovisualBody()),
        ));
  }

  SliverAppBar getAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: Colors.black87,
      elevation: 5,
      expandedHeight: MediaQuery.of(context).size.height * 0.6,
      primary: true,
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            centerTitle: false,
            title: AnimatedOpacity(
                duration: Duration(milliseconds: 150),
                opacity: top <= 85.0 ? 1.0 : 0.0,
                child: Text(
                  _audiovisual.titulo,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                )),
            background: Stack(alignment: AlignmentDirectional.center,
                // fit: StackFit.loose,
                children: <Widget>[
                  _audiovisual.imageUrl == null
                      ? new DefaultAudiovisualImage(
                          heigth: MediaQuery.of(context).size.height * 0.6)
                      : Image.network(
                          _audiovisual.imageUrl,
                          fit: BoxFit.fill,
                          // height: MediaQuery.of(context).size.height * 0.6,
                          height: double.infinity,
                          // color: Colors.black54.withAlpha(172),
                          // colorBlendMode: BlendMode.srcOver,
                        ),
                  BackdropFilter(
                    filter: new prefix0.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _audiovisual.titulo,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.solidImage),
                          color: Colors.white,
                          iconSize: 50,
                          onPressed: _audiovisual.imageUrl != null &&
                                  _audiovisual.imageUrl.isNotEmpty
                              ? () => showAudiovisualImage(context)
                              : null,
                        )
                      ],
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }

  buildAudiovisualBody() {
    var children = [
      // new AudiovisualTitle(
      //     title: _audiovisual.titulo, value: _audiovisual.titulo),

      /// SINOPSIS
      // buildDivider(_audiovisual.sinopsis),
      new AudiovisualContentHorizontal(
        label: 'Sinopsis',
        content: _audiovisual.sinopsis,
      ),

      /// PAIS
      buildDivider(_audiovisual.pais),
      new AudiovisualContentHorizontal(
        label: 'Pais',
        content: _audiovisual.pais,
      ),

      /// TAMAÑO
      buildDivider(_audiovisual.tamanno),
      new AudiovisualContentHorizontal(
        label: 'Tamaño',
        content: _audiovisual.tamanno,
      ),

      /// FORMATO
      buildDivider(_audiovisual.formato),
      new AudiovisualContentHorizontal(
        label: 'Formato',
        content: _audiovisual.formato,
      ),

      /// CAPITULOS
      buildDivider(_audiovisual.capitulos),
      new AudiovisualContentHorizontal(
        label: 'Capitulos',
        content: _audiovisual.capitulos,
      ),

      /// DIRECTOR
      buildDivider(_audiovisual.director),
      new AudiovisualContentHorizontal(
        label: 'Director',
        content: _audiovisual.director,
      ),

      /// AÑO
      buildDivider(_audiovisual.anno),
      new AudiovisualContentHorizontal(
        label: 'Año',
        content: _audiovisual.anno,
      ),

      /// PRODUCTORA
      buildDivider(_audiovisual.productora),
      new AudiovisualContentHorizontal(
          label: 'Productora', content: _audiovisual.productora),

      /// DURACION
      buildDivider(_audiovisual.duracion),
      new AudiovisualContentHorizontal(
          label: 'Duración', content: _audiovisual.duracion),

      ///
      buildDivider(_audiovisual.idioma),
      new AudiovisualContentHorizontal(
          label: 'Idioma', content: _audiovisual.idioma),

      ///
      buildDivider(_audiovisual.reparto),
      new AudiovisualContentHorizontal(
          label: 'Reparto', content: _audiovisual.reparto),
    ];
    /* ) */;
    return <Widget>[
      Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: children,
          ),
        ),
      ),
    ];
  }

  Widget buildDivider(String value) {
    return Visibility(
      visible: value != null && value.isNotEmpty,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: new Divider(
            height: 1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  showAudiovisualImage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ZoomImage(
                  imageUrl: _audiovisual.imageUrl,
                )));
  }
}

class ZoomImage extends StatelessWidget {
  final String imageUrl;

  const ZoomImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
//          Container(
//              child: PhotoView(
//                  imageProvider: NetworkImage(imageUrl))),
          Container(
              color: Colors.black,
              child: Center(
                  child: Image.network(
                imageUrl,
                width: w,
                height: h * 0.8,
                fit: BoxFit.fill,
              ))),
          SizedBox(
              height: 80,
              child: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white),
              )),
        ],
      ),
    );
  }
}

class AudiovisualContentHorizontal extends StatelessWidget {
  final String label;
  final String content;

  const AudiovisualContentHorizontal({Key key, this.label, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: content != null && content.isNotEmpty,
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            label,
          ),
          subtitle: Text(
            content != null && content.isNotEmpty ? content : '',
          ),
        ),
      ),
    );
  }
}

class AudiovisualTitle extends StatelessWidget {
  const AudiovisualTitle({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null && value.isNotEmpty,
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
    paint.color = Colors.black12;
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
