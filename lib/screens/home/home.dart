import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model_image.dart';
import 'package:silapis/models/model_location.dart';
import 'package:silapis/widgets/widget.dart';
import 'component/social_media.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));

    final images = [
      'assets/images/1.jpeg',
      'assets/images/2.jpeg',
      'assets/images/3.jpeg',
      'assets/images/4.jpeg',
      'assets/images/5.jpeg',
      'assets/images/6.jpeg',
      'assets/images/7.jpeg',
      'assets/images/8.jpeg',
      'assets/images/9.jpeg',
      'assets/images/10.jpeg',
      'assets/images/11.jpeg',
      'assets/images/12.jpeg',
      'assets/images/13.jpeg',
      'assets/images/14.jpeg',
      'assets/images/15.jpeg',
      'assets/images/16.jpeg',
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // value: SystemUiOverlayStyle(
      // statusBarColor:
      //     Theme.of(context).primaryColor, //i like transaparent :-)
      // systemNavigationBarColor: Colors.white, // navigation bar color
      // statusBarIconBrightness: Brightness.light, // status bar icons' color
      // systemNavigationBarIconBrightness:
      //     Brightness.light, //navigation bar icons' color
      // ),
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          brightness: Brightness.dark,
          elevation: 0,
        ),
        body: ListView(
          // padding: EdgeInsets.only(top: 0),
          children: [
            _header(),

            // BANNER
            Container(
              margin: EdgeInsets.only(bottom: Dimens.padding),
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Swiper(
                viewportFraction: 0.9,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.photoPreview, arguments: {
                        'index': index,
                        'photo':
                            images.map((e) => ImageModel(index, e, '')).toList()
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: Dimens.padding, horizontal: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        // margin: EdgeInsets.only(bottom: 25),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            )),
                        //   child: CachedNetworkImage(
                        //   fit: BoxFit.cover,
                        //   imageUrl: images[index],
                        // ),
                      ),
                    ),
                  );
                },
                autoplayDelay: 5000,
                autoplayDisableOnInteraction: false,
                autoplay: true,
                itemCount: images.length,
                pagination: SwiperPagination(
                  alignment: Alignment(0, 1.2),
                  builder: new DotSwiperPaginationBuilder(
                      color: Colors.grey,
                      activeColor: Theme.of(context).primaryColor),
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
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    child: Icon(
                        isGrid ? EvaIcons.listOutline : EvaIcons.gridOutline),
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
                    color: Theme.of(context).primaryColor,
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/71/29/1PCyiH.jpg',
                    keterangan:
                        'Menu antrian online, disediakan untuk membuat antrian secara online yang dapat di akses dari manapun dan kapanpun.',
                    onTap: () async {
                      final status = await Navigator.pushNamed(
                          context, Routes.antrianOnline);

                      if (status != null) {
                        Navigator.pushNamed(context, Routes.daftarAntrian);
                      }
                    },
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/3/67/i3T8eU.jpg',
                    keterangan:
                        'Menu daftar antrian online, disediakan untuk melihat antrian online yang sudah dibuat dan dapat di akses dari manapun dan kapanpun.',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Daftar Antrian',
                    icons: FontAwesomeIcons.bookOpen,
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.daftarAntrian);
                    },
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/69/18/NUOP6C.jpg',
                    keterangan:
                        'Lokasi Lapas Narkotika Karangintan Kalimantan Selatan',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Lokasi Lapas',
                    icons: FontAwesomeIcons.mapMarkerAlt,
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.location,
                          arguments: LocationModel(
                              1, 'Lokasi Lapas', -3.0299249, 115.45091));
                    },
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/5/83/FSbHPm.jpg',
                    keterangan: '-',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Data SDP',
                    icons: FontAwesomeIcons.book,
                    color: Theme.of(context).primaryColor,
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/74/56/cOHUvX.jpg',
                    keterangan:
                        'Berisi Informasi jadwal kunjungan untuk warga binaan pemasyarakatan di Lembaga Pemasyarakatan Kelas IIA Kalimantan Selatan',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Jadwal Kunjungan',
                    icons: FontAwesomeIcons.calendarAlt,
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.jadwalKunjungan,
                      );
                    },
                  ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/10/29/FhiT5K.jpg',
                    keterangan:
                        'Mempermudah keluarga warga binaan pemasyarakatan untuk melakukan pengusulan program integrasi (PB, CB, CMB dan Asimilasi).',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Pengajuan Integrasi',
                    icons: FontAwesomeIcons.handsHelping,
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.pengajuanIntegrasi,
                      );
                    },
                  ),
                  // AppMenuBox(
                  //   backgroundImage:
                  //       'https://mcdn.wallpapersafari.com/medium/25/35/Y7Xdm8.jpg',
                  //   keterangan:
                  //       'Menampilkan berita seputar Lapas Narkotika Karangintan Kalimantan Selatan',
                  //   viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                  //   name: 'Berita Terbaru',
                  //   icons: FontAwesomeIcons.newspaper,
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       Routes.news,
                  //     );
                  //   },
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  // AppMenuBox(
                  //   backgroundImage:
                  //       'https://mcdn.wallpapersafari.com/medium/46/34/Mxjr2p.jpg',
                  //   keterangan:
                  //       'Struktur Organisasi Lapas Narkotika Karangintan Kalimantan Selatan',
                  //   viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                  //   name: 'Struktur',
                  //   icons: FontAwesomeIcons.sitemap,
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       Routes.strukturOrganisasi,
                  //     );
                  //   },
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  AppMenuBox(
                    backgroundImage:
                        'https://mcdn.wallpapersafari.com/medium/65/86/3m6AIX.jpg',
                    keterangan:
                        'masyarakat dapat menyampaikan keluhan / aduan dan saran sebagai bentuk akuntabilitas, transparantasi dan profesionalisme',
                    viewType: isGrid ? ViewType.GRID : ViewType.LIST,
                    name: 'Layanan Pengaduan',
                    icons: FontAwesomeIcons.comments,
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.layananPengaduan,
                      );
                    },
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

  Widget _header() {
    return Stack(
      children: [
        new SizedBox.fromSize(
          size: Size.fromHeight(170.0),
          child: new LayoutBuilder(builder: (context, constraint) {
            final width = constraint.maxWidth * 8;
            return new ClipRect(
              child: new OverflowBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: width,
                      child: new Padding(
                        padding: new EdgeInsets.only(
                            bottom:
                                width / 2 - Size.fromHeight(170.0).height / 2),
                        child: new DecoratedBox(
                          decoration: new BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        //HEADER
        Container(
          margin: EdgeInsets.symmetric(
              vertical: Dimens.padding * 2, horizontal: Dimens.padding * 2),
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
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                'KELAS IIA KARANGINTAN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'KALIMANTAN SELATAN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
