import 'package:flutter/material.dart';
import 'package:silapis/states/state.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();

  bool _showPassword = false;
  bool _loading = false;
  AuthState authState;

  Map<String, String> _validate = {
    'username': null,
    'password': null,
  };

  @override
  void initState() {
    _textIDController.text = "";
    _textPassController.text = "";
    authState = Provider.of<AuthState>(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  ///On navigate forgot password
  void _registrasi() {
    Navigator.pushNamed(context, Routes.registrasi);
  }

  void serverValidate(Map<String, dynamic> message) {
    _validate.forEach((key, value) {
      _validate[key] = message[key];
    });
    setState(() {});
  }

  ///On login
  void _login() async {
    setState(() {
      _loading = true;
    });
    final apiModel = await SilakiRepository.auth(
        _textIDController.text, _textPassController.text);
    print(apiModel.code);

    if (apiModel.code == CODE.VALIDATE) {
      if (apiModel.message is String) {
        _validate.forEach((key, value) {
          _validate[key] = '';
        });

        appMyInfoDialog(
          context: context,
          title: 'Informasi',
          image: Images.Monitor,
          message: apiModel.message,
        );
      } else {
        serverValidate(apiModel.message);
      }
    } else if (apiModel.code == CODE.SUCCESS) {
      authState.setToken(
          apiModel.data['accessToken'], apiModel.data['refreshToken']);
    } else {
      appMyInfoDialog(
        context: context,
        title: 'Informasi',
        image: Images.Monitor,
        message: apiModel.message,
      );
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(top: 0),
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        )),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        )),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/clock.png'))),
                        )),
                  ),
                  Positioned(
                    child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    top: 40,
                    width: 80,
                    child: InkWell(
                        child: Icon(Icons.arrow_back, color: Colors.white),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
            FadeAnimation(
              1,
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      AppTextInput(
                        hintText: 'Username',
                        errorText: _validate['username'] ?? '',
                        icon: Icon(Icons.clear),
                        controller: _textIDController,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textIDController.clear();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      AppTextInput(
                        hintText: 'Password',
                        errorText: _validate['password'] ?? '',
                        textInputAction: TextInputAction.done,
                        onSubmitted: (text) {
                          _login();
                        },
                        onTapIcon: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        obscureText: !_showPassword,
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        controller: _textPassController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.resetPassword);
                            },
                            child: Text(
                              'Lupa Password ?',
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Row(children: [
                        Expanded(
                          child: AppMyButton(
                            onPress: () {
                              _login();
                            },
                            text: 'Login',
                            buttonColor: Color.fromRGBO(143, 148, 251, 1),
                            loading: _loading,
                          ),
                        ),
                      ]),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomPaint(painter: Drawhorizontalline(true)),
                            Text(
                              "Atau",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            CustomPaint(painter: Drawhorizontalline(false))
                          ],
                        ),
                      ),
                      Row(children: [
                        Expanded(
                          child: AppMyButton(
                            onPress: _registrasi,
                            text: 'Registrasi',
                            buttonColor: Colors.green,
                            loading: false,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
