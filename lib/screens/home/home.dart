import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model_location.dart';
import 'package:silapis/widgets/widget.dart';
import 'component/social_media.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Routes route = Routes();

  bool isGrid = true;

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
                    'LEMBAGA PERMASYARAKATAN NARKOTIKA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  Text(
                    'KELAS IIA KARANGINTAN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'KALIMANTAN SELATAN',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    child: Icon(isGrid ? Icons.list_alt : Icons.grid_view),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimens.padding),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  AppMenuBox(
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Antrian Online',
                    icons: FontAwesomeIcons.bookReader,
                    color: Colors.grey,
                    route: Routes.antrianOnline,
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/71/29/1PCyiH.jpg',
                    keterangan:
                        'Menu antrian online, disediakan untuk membuat antrian secara online yang dapat di akses dari manapun dan kapanpun.',
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/3/67/i3T8eU.jpg',
                    keterangan:
                        'Menu daftar antrian online, disediakan untuk melihat antrian online yang sudah dibuat dan dapat di akses dari manapun dan kapanpun.',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Daftar Antrian',
                    icons: FontAwesomeIcons.bookOpen,
                    color: Colors.grey,
                    route: Routes.daftarAntrian,
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/69/18/NUOP6C.jpg',
                    keterangan: '-',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Lokasi Lapas',
                    icons: FontAwesomeIcons.searchLocation,
                    color: Colors.red[300],
                    route: Routes.location,
                    args:
                        LocationModel(1, 'Lokasi Lapas', -3.0299249, 115.45091),
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/5/83/FSbHPm.jpg',
                    keterangan: '-',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Data SDP',
                    icons: FontAwesomeIcons.bookReader,
                    color: Colors.green,
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/74/56/cOHUvX.jpg',
                    keterangan:
                        'Berisi Informasi jadwal kunjungan untuk warga binaan pemasyarakatan di Lembaga Pemasyarakatan Kelas IIA Kalimantan Selatan',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Jadwal Kunjungan',
                    icons: FontAwesomeIcons.calendar,
                    color: Colors.purple,
                    route: Routes.jadwalKunjungan,
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/10/29/FhiT5K.jpg',
                    keterangan:
                        'Mempermudah keluarga warga binaan pemasyarakatan untuk melakukan pengusulan program integrasi (PB, CB, CMB dan Asimilasi).',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Pengajuan Integrasi',
                    icons: FontAwesomeIcons.table,
                    color: Colors.purple,
                    route: Routes.pengajuanIntegrasi,
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/25/35/Y7Xdm8.jpg',
                    keterangan: '-',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Berita Terbaru',
                    icons: FontAwesomeIcons.newspaper,
                    route: Routes.news,
                    color: Colors.blueAccent,
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/46/34/Mxjr2p.jpg',
                    keterangan: '-',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Struktur',
                    icons: FontAwesomeIcons.codeBranch,
                    route: Routes.strukturOrganisasi,
                    color: Colors.orange,
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/65/86/3m6AIX.jpg',
                    keterangan:
                        'masyarakat dapat menyampaikan keluhan / aduan dan saran sebagai bentuk akuntabilitas, transparantasi dan profesionalisme',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
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
