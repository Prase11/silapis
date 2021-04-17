import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';

class Antrian extends StatefulWidget {
  Antrian({Key key}) : super(key: key);

  @override
  _AntrianState createState() => _AntrianState();
}

class _AntrianState extends State<Antrian> {
  final _nik = TextEditingController();
  final _namaPengunjung = TextEditingController();
  final _namaWbp = TextEditingController();
  final _bin = TextEditingController();
  String _jenisKunjungan;

  bool _loading = false;

  Map<String, String> _validate = {
    'nik': null,
    'nama': null,
    'jenis': null,
    'namaAyah': null,
    'namaWbp': null,
  };

  Future<void> onSubmit() async {
    setState(() {
      _loading = true;
    });
    final apiModel = await SilakiRepository.postAntrian({
      'nik': _nik.text,
      'nama': _namaPengunjung.text,
      'jenis': _jenisKunjungan,
      'namaAyah': _bin.text,
      'namaWbp': _namaWbp.text,
    });

    UtilLogger.log('POST ANTRIAN', apiModel.toJson());
    if (apiModel.code == CODE.VALIDATE) {
      serverValidate(apiModel.message);
    } else {}

    setState(() {
      _loading = false;
    });
  }

  void serverValidate(Map<String, dynamic> message) {
    _validate.forEach((key, value) {
      _validate[key] = message[key];
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Antrian Online',
        context: context,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
        children: [
          Text(
            'Detail Pengunjung',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          ///BLOD TYPE
          AppRadioInput(
            title: 'Jenis Kunjungan',
            data: ['Kunjungan', 'Penitipan'],
            errorText: _validate['jenis'] ?? '',
            value: _jenisKunjungan,
            onChanged: (value) {
              setState(() {
                _jenisKunjungan = value;
              });
            },
          ),

          if (_jenisKunjungan == 'Kunjungan') ...[
            SizedBox(height: Dimens.padding),
            AppAnnouncement(
                title: 'Informasi',
                content:
                    'Dikarenakan adanya COVID-19 maka kunjungan ditiadakan, harap lakukan penitipan',
                context: context,
                date: '')
          ],

          ///NIK
          AppTextInput(
            title: 'NIK',
            hintText: 'Nomor Induk Keluarga',
            errorText: _validate['nik'] ?? '',
            onTapIcon: () async {
              _nik.clear();
            },
            textInputAction: TextInputAction.next,
            onChanged: (text) {},
            icon: Icon(Icons.clear),
            controller: _nik,
          ),

          ///Nama Pengunjung
          AppTextInput(
            title: 'Nama Pengunjung',
            hintText: 'Nama Pengunjung',
            errorText: _validate['nama'] ?? '',
            onTapIcon: () async {
              _namaPengunjung.clear();
            },
            textInputAction: TextInputAction.next,
            onChanged: (text) {},
            icon: Icon(Icons.clear),
            controller: _namaPengunjung,
          ),

          SizedBox(height: 20),
          Text(
            'Detail Warga Binaan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          ///NIK
          AppTextInput(
              title: 'Nama WBP',
              hintText: 'Nama Warga Binaan Permasyarakatan',
              errorText: _validate['namaWbp'] ?? '',
              onTapIcon: () async {
                _namaWbp.clear();
              },
              textInputAction: TextInputAction.next,
              onChanged: (text) {},
              icon: Icon(Icons.clear),
              controller: _namaWbp),

          ///Nama Pengunjung
          AppTextInput(
            title: 'Bin',
            hintText: 'Nama Ayah',
            errorText: _validate['namaAyah'] ?? '',
            onTapIcon: () async {
              _bin.clear();
            },
            textInputAction: TextInputAction.next,
            onChanged: (text) {},
            icon: Icon(Icons.clear),
            controller: _bin,
          ),

          SizedBox(height: 20),
          // BUTTON
          AppMyButton(
            loading: _loading,
            icon: Icons.save,
            text: 'Proses Antrian',
            onPress: onSubmit,
          ),
          // OutlineButton(
          //     child: Padding(
          //       padding: EdgeInsets.all(15),
          //       child: Container(
          //           width: MediaQuery.of(context).size.width,
          //           child: Center(
          //               child: Text(
          //             'Proses Antrian',
          //             style: TextStyle(
          //                 color: Color(0xff27AE60),
          //                 fontWeight: FontWeight.bold),
          //           ))),
          //     ),
          //     borderSide: BorderSide(color: Color(0xff27AE60)),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8)),
          //     color: Colors.white,
          //     onPressed: () {}),
        ],
      ),
    );
  }
}
