import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/widgets/widget.dart';

class Home extends StatelessWidget {
  final Routes route = Routes();

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://dailyspin.id/wp-content/uploads/2021/03/Acil-Lemon-1.jpg',
      'https://dailyspin.id/wp-content/uploads/2020/08/MPL-S6-3.jpg',
      'https://dailyspin.id/wp-content/uploads/2020/06/razer-phone-game-booster-hero.jpg',
    ];

    final menuData = [
      {
        'name': 'Edit Profil',
        'icon': FontAwesomeIcons.pencilAlt,
        'color': Colors.grey,
      },
      {
        'name': 'Daftar Antrian',
        'icon': FontAwesomeIcons.angleDoubleRight,
        'color': Colors.grey,
      },
      {
        'name': 'Scan Barcode',
        'icon': FontAwesomeIcons.qrcode,
        'color': Colors.grey,
      },
      {
        'name': 'Profil',
        'icon': FontAwesomeIcons.user,
        'color': Colors.blue,
      },
      {
        'name': 'Struktur',
        'icon': FontAwesomeIcons.stumbleuponCircle,
        'route': Routes.news,
        'color': Colors.orange,
      },
      {
        'name': 'Alur Penitipan Barang',
        'icon': FontAwesomeIcons.briefcase,
        'route': Routes.news,
        'color': Colors.orange[900],
      },
      {
        'name': 'Alur Kunjungan',
        'icon': FontAwesomeIcons.bookReader,
        'route': Routes.news,
        'color': Colors.green,
      },
      {
        'name': 'Alur Penerimaan',
        'icon': FontAwesomeIcons.personBooth,
        'route': Routes.news,
        'color': Colors.red,
      },
      {
        'name': 'Jadwal Kunjungan',
        'icon': FontAwesomeIcons.calendar,
        'route': Routes.news,
        'color': Colors.purple,
      },
      {
        'name': 'Daftar Kunjungan',
        'icon': FontAwesomeIcons.table,
        'route': Routes.news,
        'color': Colors.purple,
      },
      {
        'name': 'Galeri Serba Serbi',
        'icon': FontAwesomeIcons.chartPie,
        'route': Routes.news,
        'color': Colors.red,
      },
      {
        'name': 'Coorporate University',
        'icon': FontAwesomeIcons.university,
        'route': Routes.news,
        'color': Colors.greenAccent,
      },
      {
        'name': 'Berita Terbaru',
        'icon': FontAwesomeIcons.newspaper,
        'route': Routes.news,
        'color': Colors.blueAccent,
      },
      {
        'name': 'Riwayat Kunjungan',
        'icon': FontAwesomeIcons.history,
        'color': Colors.blueGrey,
      },
      {
        'name': 'Logout',
        'icon': Icons.logout,
        'color': Colors.red,
      },
    ];

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Swiper(
              viewportFraction: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    // margin: EdgeInsets.only(bottom: 25),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: images[index],
                    ),
                  ),
                );
              },
              autoplayDelay: 5000,
              autoplayDisableOnInteraction: false,
              autoplay: true,
              itemCount: images.length,
              pagination: SwiperPagination(
                alignment: Alignment(0, .9),
                builder: SwiperPagination.dots,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: menuData
                  .map((data) => AppMenuBox(
                        name: data['name'],
                        icons: data['icon'],
                        color: data['color'],
                        route: data['route'],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
