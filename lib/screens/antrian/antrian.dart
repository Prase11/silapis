import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:provider/provider.dart';
import 'package:silapis/states/state_antrian.dart';
import 'component/cari_lapas.dart';

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

  NapiModel _napiData;
  String _jenisKunjungan;

  bool _loading = false;

  Map<String, String> _validate = {
    'nik': null,
    'nama': null,
    'jenis': null,
    'napiId': null,
    'namaWbp': null,
  };

  Future<void> onSubmit() async {
    AntrianState antrianState =
        Provider.of<AntrianState>(context, listen: false);

    setState(() {
      _loading = true;
    });
    final apiModel = await SilakiRepository.postAntrian({
      'nik': _nik.text,
      'nama': _namaPengunjung.text,
      'jenis': _jenisKunjungan,
      'napiId': _napiData?.id,
    });

    UtilLogger.log('POST ANTRIAN', apiModel.toJson());
    if (apiModel.code == CODE.VALIDATE) {
      serverValidate(apiModel.message);
    } else if (apiModel.code == CODE.SUCCESS) {
      appMyInfoDialog(
          context: context,
          title: 'Sukses',
          message: apiModel.message ?? 'Antrian berhasil dilakukan',
          onTapText: 'Lihat Antrian',
          onTap: () {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
            antrianState.refreshData();
          });
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
          // Text(
          //   'Detail Pengunjung',
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          // ),

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
          ] else if (_jenisKunjungan == 'Penitipan') ...[
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
              readOnly: true,
              title: 'Nama WBP',
              hintText: 'Nama Warga Binaan dan Nama Ayah',
              errorText: _validate['napiId'] ?? '',
              textInputAction: TextInputAction.next,
              onChanged: (text) {},
              controller: _namaWbp,
              onTap: () async {
                NapiModel res = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CariLapas()),
                );

                if (res != null) {
                  _napiData = res;
                  _namaWbp.text = _napiData.nama;
                }
              },
              icon: Icon(Icons.keyboard_arrow_down_outlined),
            ),

            SizedBox(height: 20),
            // BUTTON
            AppMyButton(
              loading: _loading,
              icon: Icons.save_outlined,
              text: 'Proses Antrian',
              onPress: onSubmit,
            ),
          ] else ...[
            AppInfo(
              title: 'Pilih Jenis Kunjungan Anda',
              message: '',
              image: Images.Info,
            ),
          ]
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
