import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: widget.title ?? 'BERITA',
        context: context,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 0),
        children: news
            .map((e) => AppNewsContent(
                  judul: e['judul'],
                  tanggal: e['tanggal'],
                  onTap: () {
                    Navigator.pushNamed(context, Routes.newsDetail,
                        arguments: e);
                  },
                  image: e['image'],
                ))
            .toList(),
      ),
    );
  }
}
