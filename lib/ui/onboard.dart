import 'package:catalogo/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class OnboardPage extends StatefulWidget {
  OnboardPage({Key key}) : super(key: key);

  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new IntroViewsFlutter(
        pages,
        showSkipButton: true,
        skipText: Text('Saltar'),
        doneText: Text('Continuar'),
        onTapDoneButton: () => goHome(context),
        onTapSkipButton: () => goHome(context),
        pageButtonTextStyles: new TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: "Roboto",
        ),
      ),
    );
  }

  void goHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/login'));
  }
}

final pages = [
  new PageViewModel(
    pageColor: Colors.blue,
    body: Text(
      'Texto de la primera pagina',
      style: new TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: "Roboto",
      ),
    ),
    title: Text(''),
    mainImage: Image.asset(
      'assets/images/onboard_1.png',
      height: 350.0,
      width: 350.0,
      alignment: Alignment.topCenter,
    ),
    textStyle: TextStyle(color: Colors.white),
  ),
  new PageViewModel(
    pageColor: Colors.blue,
    body: Text(
      'Texto de la segunda pagina',
      style: new TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: "Roboto",
      ),
    ),
    title: Text(''),
    mainImage: Image.asset(
      'assets/images/onboard_2.png',
      height: 350.0,
      width: 350.0,
      alignment: Alignment.topCenter,
    ),
    textStyle: TextStyle(color: Colors.white),
  )
];
