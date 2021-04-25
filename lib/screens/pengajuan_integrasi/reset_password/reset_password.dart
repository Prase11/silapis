import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';
import 'package:flutter/services.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() {
    return _ResetPasswordState();
  }
}

class _ResetPasswordState extends State<ResetPassword> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();

  bool _showPassword = false;
  String _validID;
  String _validPass;

  @override
  void initState() {
    _textIDController.text = "";
    _textPassController.text = "";
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  ///On navigate forgot password
  void _registrasi() {
    Navigator.pushNamed(context, Routes.registrasi);
  }

  ///On login
  void _login() {
    Navigator.pushNamed(context, Routes.pengajuanIntegrasi);
    if (_validID == null && _validPass == null) {}
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
                              "Reset Password",
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
                        title: 'Email',
                        hintText: 'Email',
                        errorText: null,
                        icon: Icon(Icons.clear),
                        controller: _textIDController,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          _textIDController.clear();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Row(children: [
                        Expanded(
                          child: AppMyButton(
                            onPress: () {},
                            text: 'Reset password',
                            icon: Icons.vpn_key,
                            buttonColor: Color.fromRGBO(143, 148, 251, 1),
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
