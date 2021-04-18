import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';

class News extends StatefulWidget {
  final String title;
  News({Key key, this.title}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final news = [
    {
      'judul': 'GATHERING MEDIA',
      'tanggal': DateTime.now(),
      'image':
          'https://dailyspin.id/wp-content/uploads/2021/03/Acil-Lemon-1.jpg',
    },
    {
      'judul': 'KOMITMEN BERSAMA 2020',
      'tanggal': DateTime.now(),
      'image': 'https://dailyspin.id/wp-content/uploads/2020/08/MPL-S6-3.jpg',
    },
    {
      'judul': 'Sosialisasi Pencegahan Penyebaran Covid 19',
      'tanggal': DateTime.now(),
      'image':
          'https://dailyspin.id/wp-content/uploads/2020/06/razer-phone-game-booster-hero.jpg',
    },
    {
      'judul': 'KEGIATAN PEMBINAAN KEMANDIRIAN PRAMUKA',
      'tanggal': DateTime.now(),
      'image': 'https://dailyspin.id/wp-content/uploads/2020/09/Dr-Booster.jpg',
    }
  ];

  BeritaListModel beritaList;

  Future getData() async {
    final _berita = await SilakiRepository.getBerita();
    if (_berita.code == CODE.SUCCESS) {
      beritaList = BeritaListModel.fromJson(_berita.data);
      // UtilLogger.log('DATA', beritaList.list.map((e) => e.toJson()));
      setState(() {});
    }
  }

  List _loading() {
    return List.generate(4, (index) => index)
        .map((antrian) => AppNewsContent())
        .toList();
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
        title: 'Berita',
        context: context,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        children: beritaList == null
            ? _loading()
            : beritaList.list
                .map((berita) => Container(
                    width: double.infinity,
                    // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                    child: AppNewsContent(
                        judul: berita.judul,
                        tanggal: berita.tanggal,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.newsDetail,
                              arguments: berita);
                        },
                        image: berita.gambar)))
                .toList(),
      ),
    );
  }
}
