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
import 'package:cached_network_image/cached_network_image.dart';

class Antrian extends StatefulWidget {
  Antrian({Key key}) : super(key: key);

  @override
  _AntrianKunjunganState createState() => _AntrianKunjunganState();
}

class _AntrianKunjunganState extends State<Antrian> {
  final _nik = TextEditingController();
  final _namaPengunjung = TextEditingController();
  final _namaWbp = TextEditingController();
  final _keterangan = TextEditingController();

  bool _antrianKunjungan = false;

  NapiModel _napiData;
  String _jenisKunjungan;
  String _kunjungan =
      'https://i1.wp.com/lapas-narkotikajkt.com/wp-content/uploads/2019/03/ALUR-LAYANAN-KUNJUNGAN-01-2.jpg';

  bool _loading = false;

  Map<String, String> _validate = {
    'nik': null,
    'nama': null,
    'jenis': null,
    'napiId': null,
    'namaWbp': null,
    'keterangan': null,
  };

  Future<void> onSubmit() async {
    AntrianKunjunganState antrianKunjunganState =
        Provider.of<AntrianKunjunganState>(context, listen: false);

    setState(() {
      _loading = true;
    });
    final apiModel = await SilakiRepository.postAntrian({
      'nik': _nik.text,
      'nama': _namaPengunjung.text,
      'jenis': _jenisKunjungan,
      'napiId': _napiData?.id,
      'keterangan': _keterangan.text,
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
            antrianKunjunganState.refreshData();
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
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.padding, vertical: Dimens.padding),
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

          if (_jenisKunjungan == 'Kunjungan' && !_antrianKunjungan) ...[
            SizedBox(height: Dimens.padding),
            AppAnnouncement(
                title: 'Informasi',
                content:
                    'Dikarenakan adanya COVID-19 maka kunjungan ditiadakan, harap lakukan penitipan',
                context: context,
                date: '')
          ] else if (_jenisKunjungan == 'Penitipan' ||
              (_jenisKunjungan == 'Kunjungan' && _antrianKunjungan)) ...[
            AppExpandableNotifier(
              child: ScrollOnExpand(
                scrollOnExpand: false,
                scrollOnCollapse: true,
                child: Container(
                  child: ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      header: Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimens.padding),
                        child: Text(
                          "Mekanisme $_jenisKunjungan",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      expanded: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.photoPreview,
                                arguments: {
                                  'index': 0,
                                  'photo': [ImageModel(0, _kunjungan, '')]
                                });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: _kunjungan,
                            ),
                          ),
                        ),
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 0, right: 0, bottom: 0),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            crossFadePoint: 0,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

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

            ///Keterangan
            AppTextInput(
              maxLines: 4,
              title: 'Keterangan',
              hintText: 'Keterangan',
              errorText: _validate['keterangan'] ?? '',
              onTapIcon: () async {
                _keterangan.clear();
              },
              textInputAction: TextInputAction.next,
              onChanged: (text) {},
              icon: Icon(Icons.clear),
              controller: _keterangan,
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
