import 'dart:ui' as prefix0;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalogo/data/moor_database.dart';
import 'package:catalogo/providers/game_single_provider.dart';
import 'package:catalogo/widgets/default_image.dart';
import 'package:catalogo/widgets/zoom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class GameDetail extends StatefulWidget {
  static const routeName = '/gameDetail';

  @override
  _GameDetailState createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  var _isInit = true;
  var _isLoading = true;
  var _imageLoaded = false;
  GameTableData _game;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent).then((value) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      });
      _isInit = false;
      GameProvider gameProvider =
          Provider.of<GameProvider>(context, listen: false);
      gameProvider.findMyData(context).then((value) {
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
              _game = value;
            });
        }
      });
    }
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
            color: Colors.black.withAlpha(32),
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
          delegate: SliverChildListDelegate(buildGameBody()),
        ));
  }

  Color getRatingColor(String score) {
    try {
      var d = double.parse(score);
      if (d < 60) {
        return Colors.redAccent;
      } else if (d < 90) {
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
                opacity: top <= umbral ? 1.0 : 0.0,
                child: Text(
                  _game.titulo,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                )),
            background: Stack(alignment: AlignmentDirectional.center,
                // fit: StackFit.loose,
                children: <Widget>[
                  _game.image == null || !_imageLoaded
                      ? new DefaultAudiovisualImage(
                          heigth: MediaQuery.of(context).size.height * 0.6)
                      : CachedNetworkImage(
                          imageUrl: 'https://images.igdb.com/igdb/image/upload/t_screenshot_med/${_game.image}.jpg',
                          placeholder: (_, __) => SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (ctx, _, __) => DefaultAudiovisualImage(
                              heigth: MediaQuery.of(ctx).size.height * 0.6),
                          fit: BoxFit.fill,
                          height: double.infinity,
                        ),
                  BackdropFilter(
                    filter: new prefix0.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 20,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: getRatingColor(_game.score),
                          child: Text(
                            _game.score ?? '-',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        Consumer<GameProvider>(
                          builder: (ctx, product, child) => LikeButton(
                            likeBuilder: (bool isLiked) => Icon(
                              product.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: product.isFavourite
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            onTap: (isFav) =>
                                product.toggleFavourite(context: context, game: _game),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _game.titulo,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        IconButton(
                          icon: Icon(_imageLoaded
                              ? FontAwesomeIcons.solidImage
                              : FontAwesomeIcons.cloudDownloadAlt),
                          color: Colors.white,
                          iconSize: 50,
                          onPressed:
                              _game.image != null && _game.image.isNotEmpty
                                  ? () {
                                      if (!_imageLoaded) {
                                        setState(() {
                                          _imageLoaded = true;
                                        });
                                      } else
                                        return showGameImage(context);
                                    }
                                  : null,
                        ),
                      ],
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }

  buildGameBody() {
    var children = [
      // new GameTitle(
      //     title: _game.titulo, value: _game.titulo),

      /// SINOPSIS
      // buildDivider(_game.sinopsis),
      new GameContentHorizontal(
        label: 'Sinópsis',
        content: _game.sinopsis,
      ),

      /// Puntuacion
      buildDivider(_game.score),
      new GameContentHorizontal(
        label: 'Valoracion',
        content: _game.score,
      ),

      /// Empresa
      buildDivider(_game.empresa),
      new GameContentHorizontal(
        label: 'Franquisia',
        content: _game.empresa,
      ),

      /// GENERO
      buildDivider(_game.genre),
      new GameContentHorizontal(
        label: 'Género',
        content: _game.genre,
      ),

      /// PLATAFORMAS
      buildDivider(_game.plataformas),
      new GameContentHorizontal(
        label: 'Plataformas',
        content: _game.plataformas,
      ),

      /// Fecha Lanzamiento
      buildDivider(_game.fechaLanzamiento?.toIso8601String()),

      new GameContentHorizontal(
        label: 'Fecha de Lanzamiento',
        content: _game.fechaLanzamiento != null
            ? DateFormat.yM().format(_game.fechaLanzamiento)
            : '-',
      ),
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

  showGameImage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ZoomImage(
                  imageUrl: 'https://images.igdb.com/igdb/image/upload/t_screenshot_med/${_game.image}.jpg',
                )));
  }
}

class GameContentHorizontal extends StatelessWidget {
  final String label;
  final String content;

  const GameContentHorizontal({Key key, this.label, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: content != null && content.isNotEmpty,
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

class GameTitle extends StatelessWidget {
  const GameTitle({
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
                .title /*TextStyle(fontWeight: FontWeight.bold)*/,
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
