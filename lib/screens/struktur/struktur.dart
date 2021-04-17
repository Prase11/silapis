import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';
import 'package:silapis/widgets/widget.dart';

class Struktur extends StatefulWidget {
  Struktur({Key key}) : super(key: key);

  @override
  _StrukturState createState() => _StrukturState();
}

class _StrukturState extends State<Struktur> {
  PegawaiListModel pegawaiList;

  Future getData() async {
    final data = await SilakiRepository.getPegawai();
    if (data.code == CODE.SUCCESS) {
      pegawaiList = PegawaiListModel.fromJson(data.data);
      setState(() {});
      UtilLogger.log('DATA', pegawaiList.list.map((e) => e.toJson()));
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Struktur Organisasi',
        context: context,
      ),
      body: pegawaiList == null
          ? _loading()
          : ListView(
              children: [
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(Dimens.padding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(9),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://lpsragen.files.wordpress.com/2012/11/lapas-6-728.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.photoPreview,
                        arguments: {
                          'index': 0,
                          'photo': [
                            ImageModel(
                                0,
                                'https://lpsragen.files.wordpress.com/2012/11/lapas-6-728.jpg',
                                'Struktur Organisasi')
                          ]
                        });
                  },
                ),
                ...pegawaiList.list
                    .map((pegawai) => AppPersonCard(
                          pegawai,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.photoPreview,
                                arguments: {
                                  'index': 0,
                                  'photo': [
                                    ImageModel(
                                        0, pegawai.foto, 'Struktur Organisasi')
                                  ]
                                });
                          },
                        ))
                    .toList()
              ],
            ),
    );
  }

  Widget _loading() {
    return ListView(
      children: [
        ...List.generate(4, (index) => index)
            .map((pegawai) => AppPersonCard(null))
            .toList()
      ],
    );
  }
}
