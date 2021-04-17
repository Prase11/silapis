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
  AntrianListModel antrianList;

  Future getData() async {
    final data = await SilakiRepository.getAntrian();
    if (data.code == CODE.SUCCESS) {
      antrianList = AntrianListModel.fromJson(data.data);
      setState(() {});
      UtilLogger.log('DATA', antrianList.list.map((e) => e.toJson()));
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
      body: antrianList == null
          ? _loading()
          : ListView(
              children: [
                InkWell(
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://mcdn.wallpapersafari.com/medium/46/34/Mxjr2p.jpg',
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
                                'https://mcdn.wallpapersafari.com/medium/46/34/Mxjr2p.jpg',
                                'Struktur Organisasi')
                          ]
                        });
                  },
                ),
                ...antrianList.list
                    .map((antrian) => AppPersonCard(
                          antrian,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.photoPreview,
                                arguments: {
                                  'index': 0,
                                  'photo': [
                                    ImageModel(
                                        0,
                                        'https://mcdn.wallpapersafari.com/medium/46/34/Mxjr2p.jpg',
                                        'Struktur Organisasi')
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
            .map((antrian) => AppPersonCard(null))
            .toList()
      ],
    );
  }
}
