import 'package:catalogo/block/block.dart';
import 'package:catalogo/graphql/resolver.dart';
import 'package:catalogo/service.dart';
import 'package:catalogo/ui/home.dart';
import 'package:catalogo/ui/util.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserBloc block = UserBloc();

  final textUserController = TextEditingController();
  final textPassController = TextEditingController();

  final textEmailController = TextEditingController();
  final textPassSignController = TextEditingController();
  final textUserSignController = TextEditingController();

  String actualUsername;
  String actualEmail;
  String actualPassword;

  bool isLoading = false;

  final FocusNode focusNodeUserLogin = new FocusNode();
  final FocusNode focusNodePassLogin = new FocusNode();

  @override
  void dispose() {
    textPassController.dispose();
    textUserController.dispose();

    textEmailController.dispose();
    textPassSignController.dispose();
    textUserSignController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    service.getString(USERNAME_KEY).then((username) {
      setState(() {
        actualUsername = username;
      });
    });
    service.getString(EMAIL_KEY).then((email) {
      setState(() {
        actualEmail = email;
      });
    });
    service.getString(PASSWORD_KEY).then((pass) {
      setState(() {
        actualPassword = pass;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (actualUsername != null && actualUsername.isNotEmpty) {

    // }
    return Stack(
      children: <Widget>[
        Visibility(
          visible: !isLoading,
          child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(8),
              child: actualUsername != null && actualUsername.isNotEmpty
                  ? Center(
                      child: Card(
                        margin: EdgeInsets.all(40),
                        color: Colors.black87,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'User: $actualUsername',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                height: 10,
                              ),
                              Text('Email: $actualEmail',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              Container(
                                height: 20,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                    color: Colors.redAccent,
                                    textColor: Colors.white,
                                    onPressed: () => doLogout(),
                                    child: Text('Logout'),
                                  ),
                                  FlatButton(
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    onPressed: () => goHome(),
                                    child: Text('Continue'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : DefaultTabController(
                      length: 2,
                      child: Builder(
                        builder: (BuildContext context) {
                          return TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              getLoginPageOrientation(context),
                              buildSingUpOrientation(context)
                            ],
                          );
                        },
                      ),
                    )),
        ),
        Visibility(
            visible: isLoading,
            child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget buildSingUpOrientation(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
              Card(
                  margin: EdgeInsets.all(40),
                  elevation: 10,
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getSignUp(context),
                  )),
            ],
          );
        } else {
          return Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
              ),
              Expanded(
                flex: 2,
                child: Card(
                    margin: EdgeInsets.all(40),
                    elevation: 10,
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getSignUp(context),
                    )),
              ),
            ],
          );
        }
      },
    );
  }

  Widget getLoginPageOrientation(BuildContext context) {
    return new OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
              Card(
                  margin: EdgeInsets.all(40),
                  elevation: 10,
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: getLoginPage(context),
                  )),
            ],
          );
        } else {
          return Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
              ),
              Expanded(
                flex: 2,
                child: Card(
                    margin: EdgeInsets.all(40),
                    elevation: 10,
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: getLoginPage(context),
                    )),
              ),
            ],
          );
        }
      },
    );
  }

  Widget getSignUp(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        TextFormField(
            controller: textEmailController,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              labelText: 'Correo electronico *',
            )),
        Container(
          height: 20,
        ),
        TextFormField(
            controller: textUserSignController,
            textCapitalization: TextCapitalization.characters,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelStyle: TextStyle(color: Colors.grey),
              filled: true,
              labelText: 'Usuario *',
            )),
        Container(
          height: 20,
        ),
        PasswordField(
          controller: textPassSignController,
          labelText: 'Contraseña *',
          helperText: 'No mas de 8 caractéres',
        ),
        Container(
          height: 30,
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                color: Colors.redAccent,
                textColor: Colors.white,
                onPressed: () {
                  final TabController controller =
                      DefaultTabController.of(context);
                  if (!controller.indexIsChanging) {
                    controller.animateTo(0);
                  }
                },
                child: Text('Back'),
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () => doSignUp(textEmailController.text,
                    textUserSignController.text, textPassSignController.text),
                child: Text('Sign Up'),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getLoginPage(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: buildLogin(context),
    );
  }

  Widget buildLogo() {
    return Container(
      child: Center(child: Image.asset('assets/images/logo.png')),
    );
  }

  List<Widget> buildLogin(BuildContext context) {
    return [
      TextFormField(
          controller: textUserController,
          textCapitalization: TextCapitalization.none,
          autovalidate: true,
          textInputAction: TextInputAction.next,
          focusNode: focusNodeUserLogin,
          onFieldSubmitted: (term) {
            focusNodeUserLogin.unfocus();
            FocusScope.of(context).requestFocus(focusNodePassLogin);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Valor requerido';
            }
            return null;
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            focusColor: Colors.white,
            labelStyle: TextStyle(color: Colors.grey),
            labelText: 'Usuario *',
          )),
      Container(
        height: 20,
      ),
      PasswordField(
        controller: textPassController,
        labelText: 'Contraseña *',
        helperText: 'No mas de 8 caractéres',
        focusNode: focusNodePassLogin,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Valor requerido';
          }
          return null;
        },
      ),
      Container(
        height: 30,
      ),
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () =>
                  doLogin(textUserController.text, textPassController.text),
              child: Text('Sign in'),
            ),
            FlatButton(
              color: Colors.blueGrey,
              textColor: Colors.white,
              onPressed: () {
                final TabController controller =
                    DefaultTabController.of(context);
                if (!controller.indexIsChanging) {
                  controller.animateTo(1);
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      )
    ];
  }

  clearControllers() {
    textEmailController.clear();
    textPassController.clear();
    textPassSignController.clear();
    textUserSignController.clear();
    textUserController.clear();
  }

  doLogin(String user, String pass) {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    if (user != null && user.isNotEmpty && pass != null && pass.isNotEmpty) {
      block.login(user, pass).then((result) {
        if (result != null) {
          setState(() {
            actualUsername = user;
            actualPassword = pass;
            actualEmail = result.emailAddress;
            clearControllers();
            isLoading = false;
          });
          service.setString(TOKEN_KEY, result.sessionToken);
          service.setString(USERNAME_KEY, user);
          service.setString(EMAIL_KEY, result.emailAddress);
          service.setString(PASSWORD_KEY, pass);

          Toast.show('Welcome $user!', context,
              backgroundColor: Colors.green, textColor: Colors.white);
        } else {
          setState(() {
            isLoading = false;
          });
          Toast.show('Wrong data!', context,
              backgroundColor: Colors.red, textColor: Colors.white);
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
      Toast.show('Datos obligatorios', context,
          backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  doSignUp(String email, String user, String pass) {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    if (user != null && user.isNotEmpty && pass != null && pass.isNotEmpty) {
      block.signUp(user, pass, email).then((result) {
        if (result != null && result.sessionToken != null) {
          setState(() {
            actualUsername = user;
            actualPassword = pass;
            actualEmail = email;
            isLoading = false;
            clearControllers();
          });
          service.setString(TOKEN_KEY, result.sessionToken);
          service.setString(USERNAME_KEY, user);
          service.setString(EMAIL_KEY, result.emailAddress);
          service.setString(PASSWORD_KEY, pass);
          Toast.show('SignUp Success', context,
              backgroundColor: Colors.green, textColor: Colors.white);
        } else {
          setState(() {
            isLoading = false;
          });
          Toast.show('Wrong data!', context,
              backgroundColor: Colors.red, textColor: Colors.white);
        }
      });
    } else
      setState(() {
        isLoading = false;
      });
    Toast.show('Datos obligatorios', context,
        backgroundColor: Colors.red, textColor: Colors.white);
  }

  goHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  doLogout() {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    if (actualUsername != null &&
        actualUsername.isNotEmpty &&
        actualPassword != null &&
        actualPassword.isNotEmpty) {
      block.logout().then((result) {
        if (result) {
          setState(() {
            actualUsername = null;
            actualPassword = null;
            actualEmail = null;
            isLoading = false;
          });
          Toast.show('Logout Success', context,
              backgroundColor: Colors.green, textColor: Colors.white);
        } else {
          setState(() {
            isLoading = false;
          });
          Toast.show('Wrong data!', context,
              backgroundColor: Colors.red, textColor: Colors.white);
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
