import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:silapis/states/state.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http_parser/http_parser.dart';

class Registrasi extends StatefulWidget {
  Registrasi({Key key}) : super(key: key);

  @override
  _RegistrasiState createState() {
    return _RegistrasiState();
  }
}

class _RegistrasiState extends State<Registrasi> {
  final _textNikController = TextEditingController();
  final _textNamaController = TextEditingController();
  final _textNoHpController = TextEditingController();
  final _textTempatLahirController = TextEditingController();
  final _textTanggalLahirController = TextEditingController();
  final _textEmailController = TextEditingController();
  MultipartFileExtended fotoSelfie;
  MultipartFileExtended fotoKtp;

  final ImagePicker _picker = ImagePicker();
  String _ktpImagePicker;
  String _fotoImagePicker;
  AuthState authState;

  bool _loading = false;

  Map<String, String> _validate = {
    'nik': null,
    'nama': null,
    'noHp': null,
    'tempatLahir': null,
    'tanggalLahir': null,
    'email': null,
    'fotoKtp': null,
    'fotoSelfie': null,
  };

  @override
  void initState() {
    _textNikController.text = "";
    _textNamaController.text = "";
    _textNoHpController.text = "";
    _textTempatLahirController.text = "";
    _textTanggalLahirController.text = "";
    _textEmailController.text = "";
    authState = Provider.of<AuthState>(context, listen: false);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    super.initState();
  }

  void serverValidate(Map<String, dynamic> message) {
    _validate.forEach((key, value) {
      _validate[key] = message[key];
    });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On login
  void _registrasi() async {
    setState(() {
      _loading = true;
    });

    fotoKtp = null;
    fotoSelfie = null;

    try {
      final imagePath = _fotoImagePicker;
      final fileGambarName = imagePath.split("/").last;
      UtilLogger.log('FILE GAMBAR', fileGambarName);
      UtilLogger.log('FILE GAMBAR PATH', imagePath);

      fotoSelfie = MultipartFileExtended.fromFileSync(
        imagePath,
        filename: fileGambarName,
        contentType: MediaType("*", "*"),
      );
    } catch (e) {}

    try {
      final ktpPath = _ktpImagePicker;
      final fileKtpName = ktpPath.split("/").last;

      fotoKtp = MultipartFileExtended.fromFileSync(
        ktpPath,
        filename: fileKtpName,
        contentType: MediaType("*", "*"),
      );
    } catch (e) {}

    final apiModel = await SilakiRepository.postRegistrasi({
      'nik': _textNikController.text,
      'nama': _textNamaController.text,
      'noHp': _textNoHpController.text,
      'tempatLahir': _textTempatLahirController.text,
      'tanggalLahir': _textTanggalLahirController.text,
      'email': _textEmailController.text,
      'fotoKtp': fotoKtp,
      'fotoSelfie': fotoSelfie,
    });

    if (apiModel.code == CODE.VALIDATE) {
      serverValidate(apiModel.message);
    } else if (apiModel.code == CODE.SUCCESS) {
      authState.setToken(
          apiModel.data['accessToken'], apiModel.data['refreshToken']);
      Navigator.pop(context);
      // appMyInfoDialog(
      //     context: context,
      //     title: 'Sukses',
      //     message: apiModel.message ?? 'Antrian berhasil dilakukan',
      //     onTapText: 'Lihat Antrian',
      //     onTap: () {});
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
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(top: 0, bottom: 20),
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
                              "Registrasi",
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
                        title: 'NIK',
                        hintText: 'Nomor Induk keluarga',
                        errorText: _validate['nik'] ?? '',
                        icon: Icon(Icons.clear),
                        controller: _textNikController,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textNikController.clear();
                        },
                      ),
                      AppTextInput(
                        title: 'Nama',
                        hintText: 'Nama Lengkap',
                        errorText: _validate['nama'] ?? '',
                        icon: Icon(Icons.clear),
                        controller: _textNamaController,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textNamaController.clear();
                        },
                      ),
                      AppTextInput(
                        title: 'No Hp',
                        hintText: 'No Handphone',
                        errorText: _validate['noHp'] ?? '',
                        icon: Icon(Icons.clear),
                        controller: _textNoHpController,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textNoHpController.clear();
                        },
                      ),
                      AppTextInput(
                        readOnly: true,
                        title: 'Tanggal Lahir',
                        hintText: 'Tanggal Lahir',
                        errorText: _validate['tanggalLahir'] ?? '',
                        icon: Icon(Icons.calendar_today_outlined),
                        controller: _textTanggalLahirController,
                        textInputAction: TextInputAction.next,
                        onTap: () async {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 1, 1),
                            maxTime: DateTime.now(),
                            theme: DatePickerTheme(
                              headerColor: Color.fromRGBO(143, 148, 251, 1),
                              backgroundColor: Colors.white,
                              itemStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              doneStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (date) {
                              _textTanggalLahirController.text =
                                  unixTimeStampToDateOnly(
                                      date.millisecondsSinceEpoch);
                              setState(() {});
                              print('confirm $date');
                            },
                            currentTime: _textTanggalLahirController.text == ''
                                ? DateTime.now()
                                : DateTime.parse(
                                    _textTanggalLahirController.text),
                            locale: LocaleType.en,
                          );
                        },
                      ),
                      AppTextInput(
                        title: 'Tempat Lahir',
                        hintText: 'Tempat Lahir',
                        errorText: _validate['tempatLahir'] ?? '',
                        icon: Icon(Icons.clear),
                        controller: _textTempatLahirController,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textTempatLahirController.clear();
                        },
                      ),
                      AppTextInput(
                        title: 'Email',
                        hintText: 'Email',
                        errorText: _validate['email'] ?? '',
                        icon: Icon(Icons.clear),
                        controller: _textEmailController,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textEmailController.clear();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      AppImagePicker(
                        title: 'Foto KTP',
                        placeholder: 'Pilih Berkas KTP',
                        errorText: _validate['fotoKtp'] ?? '',
                        previewImage: _ktpImagePicker,
                        onChange: (path) {
                          _ktpImagePicker = path;
                          setState(() {});
                        },
                        onCloseFile: () {
                          _ktpImagePicker = null;
                          setState(() {});
                        },
                      ),
                      AppImagePicker(
                        title: 'Foto Selfie',
                        placeholder: 'Foto Selfie',
                        errorText: _validate['fotoSelfie'] ?? '',
                        previewImage: _fotoImagePicker,
                        onChange: (path) {
                          _fotoImagePicker = path;
                          setState(() {});
                        },
                        onCloseFile: () {
                          _fotoImagePicker = null;
                          setState(() {});
                        },
                      ),
                      Row(children: [
                        Expanded(
                          child: AppMyButton(
                            onPress: _registrasi,
                            text: 'Registrasi',
                            buttonColor: Color.fromRGBO(143, 148, 251, 1),
                            loading: _loading,
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
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
