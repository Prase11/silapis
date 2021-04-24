import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';

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
  final _focusID = FocusNode();
  final _focusPass = FocusNode();

  bool _showPassword = false;
  String _validID;
  String _validPass;

  @override
  void initState() {
    _textIDController.text = "";
    _textPassController.text = "";
    super.initState();
  }

  ///On navigate forgot password
  void _registrasi() {
    Navigator.pushNamed(context, Routes.registrasi);
    // appMyInfoDialog(
    //   context: context,
    //   message: {
    //     0: 'Operator Fakultas, jika anda seorang Dosen.',
    //     1: 'Admin Tenaga Kependidikan (Subbag Tenaga Kependidikan kepegawaian rektorat), jika anda seorang Tenaga Kependidikan.',
    //   },
    //   image: Images.ForgotPassword,
    //   title: '',
    // );
  }

  ///On login
  void _login() {
    Navigator.pushNamed(context, Routes.pengajuanIntegrasi);
    if (_validID == null && _validPass == null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Login',
        context: context,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: <Widget>[
                  Center(
                    child: SvgPicture.asset(
                      Images.Security,
                      matchTextDirection: true,
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ),
                  SizedBox(height: 40),
                  AppTextInput(
                    hintText: 'Username',
                    errorText: _validID != null ? _validID : null,
                    icon: Icon(Icons.clear),
                    controller: _textIDController,
                    focusNode: _focusID,
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
                    errorText: _validPass != null ? _validPass : null,
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
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    controller: _textPassController,
                    focusNode: _focusPass,
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
                        icon: Icons.vpn_key,
                        loading: false,
                      ),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: _registrasi,
                        child: Text(
                          'Registrasi',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
