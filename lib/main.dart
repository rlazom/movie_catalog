import 'package:catalogo/service.dart';
import 'package:catalogo/ui/home.dart';
import 'package:catalogo/ui/onboard.dart';
import 'package:flutter/material.dart';

LoginService service = new LoginService();

void main() async {
  Widget defaultWidget = Onboard();

  bool _result = await service.getString(USERNAME_KEY) != null &&
      await service.getString(TOKEN_KEY) != null;

  if (_result) {
    defaultWidget = Home();
  }

  runApp(defaultWidget);
}

class Onboard extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardPage(),
    );
  }
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}