import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:catalogo/ui/audiovisual_list.dart';
import 'package:flutter/material.dart';

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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 1,
            expandedHeight: MediaQuery.of(context).size.height / 1.7,
            primary: true,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  title: AnimatedOpacity(
                      duration: Duration(milliseconds: 150),
                      opacity: top == 80.0 ? 1.0 : 0.0,
                      child: Text(widget.audiovisual.titulo, style: TextStyle(color: Colors.black),)),
                  background: Container(
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        fit: StackFit.loose,
                        children: <Widget>[
                          widget.audiovisual.imageUrl == null
                              ? new DefaultAudiovisualImage(
                                  heigth: MediaQuery.of(context).size.height / 1.7,
                                )
                              : Image.network(
                                  widget.audiovisual.imageUrl,
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                          // Container(height: 220, color: Colors.amber),
                          CustomPaint(
                            painter: ShapesPainter(),
                            child: Container(
                              height: 50,
                              color: Colors.transparent,
                            ),
                          )
                        ]),
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(buildAudiovisualBody()),
          )
        ],
      ),
    );
  }

  buildAudiovisualBody() {
    return [
      new AudiovisualTitle(
          title: widget.audiovisual.titulo, value: widget.audiovisual.titulo),

      /// SINOPSIS
      buildDivider(widget.audiovisual.sinopsis),
      new AudiovisualContentHorizontal(
        label: 'Sinopsis',
        content: widget.audiovisual.sinopsis,
      ),

      /// PAIS
      buildDivider(widget.audiovisual.pais),
      new AudiovisualContentHorizontal(
        label: 'Pais',
        content: widget.audiovisual.pais,
      ),

      /// TAMAÑO
      buildDivider(widget.audiovisual.tamanno),
      new AudiovisualContentHorizontal(
        label: 'Tamaño',
        content: widget.audiovisual.tamanno,
      ),

      /// FORMATO
      buildDivider(widget.audiovisual.formato),
      new AudiovisualContentHorizontal(
        label: 'Formato',
        content: widget.audiovisual.formato,
      ),

      /// CAPITULOS
      buildDivider(widget.audiovisual.capitulos),
      new AudiovisualContentHorizontal(
        label: 'Capitulos',
        content: widget.audiovisual.capitulos,
      ),

      /// DIRECTOR
      buildDivider(widget.audiovisual.director),
      new AudiovisualContentHorizontal(
        label: 'Director',
        content: widget.audiovisual.director,
      ),

      /// AÑO
      buildDivider(widget.audiovisual.anno),
      new AudiovisualContentHorizontal(
        label: 'Año',
        content: widget.audiovisual.anno,
      ),

      /// PRODUCTORA
      buildDivider(widget.audiovisual.productora),
      new AudiovisualContentHorizontal(
          label: 'Productora', content: widget.audiovisual.productora),

      /// DURACION
      buildDivider(widget.audiovisual.duracion),
      new AudiovisualContentHorizontal(
          label: 'Duración', content: widget.audiovisual.duracion),

      ///
      buildDivider(widget.audiovisual.idioma),
      new AudiovisualContentHorizontal(
          label: 'Idioma', content: widget.audiovisual.idioma),

      ///
      buildDivider(widget.audiovisual.reparto),
      new AudiovisualContentHorizontal(
          label: 'Reparto', content: widget.audiovisual.reparto),
    ];
    /* ) */;
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
