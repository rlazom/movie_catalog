import 'dart:ui' as prefix0;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalogo/data/moor_database.dart';
import 'package:catalogo/providers/audiovisual_single_provider.dart';
import 'package:catalogo/ui/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../widgets/default_image.dart';
import '../widgets/zoom_image.dart';

class AudiovisualDetail extends StatefulWidget {
  static const routeName = '/audiovisualDetail';
  final bool trending;

  const AudiovisualDetail({Key key, this.trending}) : super(key: key);

  @override
  _AudiovisualDetailState createState() => _AudiovisualDetailState();
}

class _AudiovisualDetailState extends State<AudiovisualDetail> {
  var _isInit = true;
  var _isLoading = true;
  var _imageLoaded = false;
  AudiovisualTableData _audiovisual;
  AudiovisualProvider audiovisualProvider;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      audiovisualProvider =
          Provider.of<AudiovisualProvider>(context, listen: false);
      if (widget.trending ?? false)
        audiovisualProvider.findMyDataTitle(context).then((value) {
          dataLoaded(value);
        });
      else
        audiovisualProvider.findMyData(context).then((value) {
          dataLoaded(value);
        });
    }
    super.didChangeDependencies();
  }

  void dataLoaded(value) {
    if (mounted) {
      if (value == null) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('No Internet!!!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text('Aceptar'),
                      textColor: Colors.red,
                    )
                  ],
                ));
      } else
        setState(() {
          _isLoading = false;
          _audiovisual = value;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
          body: Container(
              child:
                  Center(child: SizedBox(child: CircularProgressIndicator()))));
    }
    audiovisualProvider.checkImageCached();
    return Container(
      padding:
          MediaQuery.of(context).padding.copyWith(left: 0, right: 0, bottom: 0),
      color: Colors.white,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverSafeArea(
                  top: false,
                  sliver: getAppBar(context),
                ),
              )
            ];
          },
          body: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: <Widget>[getContent()],
            ),
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

  Future<bool> onLikeButtonTap(bool isLiked, BuildContext context) {
    final ScaffoldState scaffoldState =
        context.rootAncestorStateOfType(TypeMatcher<ScaffoldState>());
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(isLiked
            ? 'Eliminado de Mis Favoritos'
            : 'Agregado a Mis Favoritos'),
      ));
    }
    return audiovisualProvider.toggleFavourite(
        context: context, audiovisual: _audiovisual);
  }

  Color getRatingColor(String score) {
    try {
      var d = double.parse(score);
      if (d < 6) {
        return Colors.redAccent;
      } else if (d < 9) {
        return Colors.yellowAccent;
      }
      return Colors.greenAccent;
    } catch (e) {
      return Theme.of(context).primaryColor;
    }
  }

  SliverAppBar getAppBar(BuildContext context) {
    final umbral = MediaQuery.of(context).size.height / 9.675 + 5;

    return SliverAppBar(
      pinned: false,
      floating: true,
      backgroundColor: HexColor('#252525'),
      elevation: 5,
      expandedHeight: MediaQuery.of(context).size.height * 0.6,
      primary: true,
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: getRatingColor(_audiovisual.score).withOpacity(0.5),
          child: Text(
            _audiovisual.score ?? '-',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        likeButton(context)
      ],
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            centerTitle: false,
//            title: AnimatedOpacity(
//                duration: Duration(milliseconds: 150),
//                opacity: top <= umbral ? 1.0 : 1.0,
//                child: Text(
//                  _audiovisual.titulo,
//                  maxLines: 1,
//                  style: TextStyle(color: Colors.white),
//                )),
            background: Stack(alignment: AlignmentDirectional.center,
                // fit: StackFit.loose,
                children: <Widget>[
                  Consumer<AudiovisualProvider>(
                      builder: (ctx, av, child) => GestureDetector(
                            onTap: () => !av.imageLoaded
                                ? av.toggleLoadImage()
                                : previewImageDialog(context, av.imageUrl),
                            child: !av.imageLoaded
                                ? new PlaceholderImage(
                                    heigth: MediaQuery.of(context).size.height *
                                        0.6)
                                : CachedNetworkImage(
                                    imageUrl: _audiovisual.image,
                                    color: Colors.black54,
                                    colorBlendMode: BlendMode.darken,
                                    placeholder: (_, __) => SizedBox(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (ctx, _, __) =>
                                        PlaceholderImage(
                                            heigth:
                                                MediaQuery.of(ctx).size.height *
                                                    0.6),
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                          )),
//                  BackdropFilter(
//                    filter: new prefix0.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                    child: Container(
//                      decoration: new BoxDecoration(
//                        color: Colors.black.withOpacity(0.5),
//                      ),
//                    ),
//                  ),
//                  Center(
//                    child: Consumer<AudiovisualProvider>(
//                        builder: (ctx, provider, child) => provider.imageLoaded
//                            ? AnimatedOpacity(
//                                duration: Duration(seconds: 5),
//                                opacity: provider.imageLoaded ? 1 : 0,
//                                child: OutlineButton(
////                                icon: Icon(FontAwesomeIcons.solidImage),
//                                    child: Text('Ver Imagen'),
//                                    textColor: Colors.white,
//                                    borderSide: BorderSide(color: Colors.white),
////                                iconSize: 50,
//                                    onPressed: () => previewImageDialog(
//                                        context, _audiovisual.image)),
//                              )
//                            : OutlineButton(
//                                child: Text('Descargar portada'),
//                                textColor: Colors.white,
//                                borderSide: BorderSide(color: Colors.white),
////                                    iconSize: 50,
//                                onPressed: () => provider.toggleLoadImage(),
//                              )),
//                  ),
                ]),
          );
        },
      ),
    );
  }

  Widget likeButton(BuildContext context) {
    return Consumer<AudiovisualProvider>(
        builder: (ctx, av, child) => IconButton(
              icon:
                  Icon(av.isFavourite ? Icons.favorite : Icons.favorite_border),
              color: av.isFavourite ? Colors.red : Colors.white,
              onPressed: () {
                return onLikeButtonTap(av.isFavourite, context);
              },
            ));
  }

  buildAudiovisualBody() {
    var children = [
      new AudiovisualTitle(
          title: _audiovisual.titulo, value: _audiovisual.titulo),

      /// SINOPSIS
      // buildDivider(_audiovisual.sinopsis),
      new AudiovisualContentHorizontal(
        label: 'Sinópsis',
        content: _audiovisual.sinopsis,
      ),

      /// GENERO
      buildDivider(_audiovisual.genre),
      new AudiovisualContentHorizontal(
        label: 'Género',
        content: _audiovisual.genre,
      ),

      /// Puntuacion
      buildDivider(_audiovisual.score),
      new AudiovisualContentHorizontal(
        label: 'Valoracion',
        content: _audiovisual.score,
      ),

      /// PAIS
      buildDivider(_audiovisual.pais),
      new AudiovisualContentHorizontal(
        label: 'Pais',
        content: _audiovisual.pais,
      ),

      /// DIRECTOR
      buildDivider(_audiovisual.director),
      new AudiovisualContentHorizontal(
        label: 'Director',
        content: _audiovisual.director,
      ),

      /// GUIONISTA
      buildDivider(_audiovisual.capitulos),
      new AudiovisualContentHorizontal(
        label: 'Guión',
        content: _audiovisual.capitulos,
      ),

      /// TEMPORADAS
      buildDivider(_audiovisual.temp),
      new AudiovisualContentHorizontal(
        label: 'Temporadas',
        content: _audiovisual.temp,
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
        margin: const EdgeInsets.all(10),
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
      visible: value != null && value.isNotEmpty && value != 'N/A',
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
                  imageUrl: _audiovisual.image,
                )));
  }

  previewImageDialog(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10)),
//              contentPadding: const EdgeInsets.all(0),
              child: imageUrl == null || imageUrl.isEmpty
                  ? Text(
                      'NADA QUE MOSTRAR',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  : Container(
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width,
//                      height: MediaQuery.of(context).size.height,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.fitWidth,
                        placeholder: (_, __) => SizedBox(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (ctx, _, __) => Center(
                          child: Text(
                            'Parece que ocurrio un error',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            ));
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
      visible: content != null && content.isNotEmpty && content != 'N/A',
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(label, style: Theme.of(context).textTheme.title),
          subtitle: Text(content != null && content.isNotEmpty ? content : '',
              style: Theme.of(context).textTheme.subtitle),
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
            style: Theme.of(context)
                .textTheme
                .display1 /*TextStyle(fontWeight: FontWeight.bold)*/,
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
