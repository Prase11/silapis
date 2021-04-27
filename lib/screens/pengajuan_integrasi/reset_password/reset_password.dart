import 'package:flutter/material.dart';
import 'package:silapis/states/state.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
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

  bool _loading = false;
  AuthState authState;

  Map<String, String> _validate = {
    'email': null,
  };

  @override
  void initState() {
    _textIDController.text = "";
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  void serverValidate(Map<String, dynamic> message) {
    _validate.forEach((key, value) {
      _validate[key] = message[key];
    });
    setState(() {});
  }

  ///On login
  void _resetPassword() async {
    setState(() {
      _loading = true;
    });
    final apiModel =
        await SilakiRepository.resetPassword(_textIDController.text);
    print(apiModel.code);
    _validate.forEach((key, value) {
      _validate[key] = '';
    });

    if (apiModel.code == CODE.VALIDATE) {
      if (apiModel.message is String) {
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
      appMyInfoDialog(
        context: context,
        title: 'Informasi',
        image: Images.Moonlight,
        message: apiModel.message,
      );
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
                        errorText: _validate['email'] ?? '',
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
                            onPress: _resetPassword,
                            text: 'Reset password',
                            buttonColor: Color.fromRGBO(143, 148, 251, 1),
                            loading: _loading,
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
