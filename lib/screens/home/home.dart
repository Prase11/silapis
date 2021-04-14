import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model_location.dart';
import 'package:silapis/widgets/widget.dart';
import 'component/social_media.dart';

class Home extends StatelessWidget {
  final Routes route = Routes();

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://dailyspin.id/wp-content/uploads/2021/03/Acil-Lemon-1.jpg',
      'https://dailyspin.id/wp-content/uploads/2020/08/MPL-S6-3.jpg',
      'https://dailyspin.id/wp-content/uploads/2020/06/razer-phone-game-booster-hero.jpg',
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            //HEADER
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: Dimens.padding, horizontal: Dimens.padding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        height: 60,
                        width: 60,
                        child: Image.asset(Images.Logo),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        height: 60,
                        width: 60,
                        child: Image.asset(Images.Permasyarakatan),
                      ),
                    ],
                  ),
                  Text(
                    'LEMBAGA PERMASYARAKATAN KELAS IIA KARANGINTAN KALIMANTAN SELATAN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'KANTOR WILAYAH KEMENTRIAN HUKUM DAN HAM KALIMANTAN SELATAN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            // BANNER
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Swiper(
                viewportFraction: 0.9,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: Dimens.padding, horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      // margin: EdgeInsets.only(bottom: 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: images[index],
                        ),
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
              padding: EdgeInsets.only(
                left: Dimens.padding,
                right: Dimens.padding,
                top: 20,
              ),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Menu',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimens.padding),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  AppMenuBox(
                    name: 'Antrian Online',
                    icons: FontAwesomeIcons.bookReader,
                    color: Colors.grey,
                    route: Routes.antrianOnline,
                  ),
                  AppMenuBox(
                    name: 'Lokasi Lapas',
                    icons: FontAwesomeIcons.searchLocation,
                    color: Colors.red[300],
                    route: Routes.location,
                    args:
                        LocationModel(1, 'Lokasi Lapas', -3.0299249, 115.45091),
                  ),
                  AppMenuBox(
                    name: 'Data SDP',
                    icons: FontAwesomeIcons.bookReader,
                    color: Colors.green,
                  ),
                  AppMenuBox(
                    name: 'Jadwal Kunjungan',
                    icons: FontAwesomeIcons.calendar,
                    color: Colors.purple,
                    route: Routes.jadwalKunjungan,
                  ),
                  AppMenuBox(
                    name: 'Pengajuan Integrasi',
                    icons: FontAwesomeIcons.table,
                    color: Colors.purple,
                    route: Routes.pengajuanIntegrasi,
                  ),
                  AppMenuBox(
                    name: 'Berita Terbaru',
                    icons: FontAwesomeIcons.newspaper,
                    route: Routes.news,
                    color: Colors.blueAccent,
                  ),
                  AppMenuBox(
                    name: 'Layanan Pengaduan',
                    icons: FontAwesomeIcons.personBooth,
                    color: Colors.blueGrey,
                    route: Routes.layananPengaduan,
                  ),
                ],
              ),
            ),
            SocialMedia(),
          ],
        ),
      ),
    );
  }
}
