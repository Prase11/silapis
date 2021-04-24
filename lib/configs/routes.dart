import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/screens/screen.dart';

class Routes {
  static const String home = "/home";
  static const String news = "/news";
  static const String newsDetail = "/newsDetail";
  static const String location = "/location";
  static const String layananPengaduan = "/layananPengaduan";
  static const String pengajuanIntegrasi = "/pengajuanIntegrasi";
  static const String jadwalKunjungan = "/jadwalKunjungan";
  static const String antrianOnline = "/antrianOnline";
  static const String daftarAntrian = "/daftarAntrian";
  static const String daftarAntrianDetail = "/daftarAntrianDetail";
  static const String strukturOrganisasi = "/strukturOrganisasi";
  static const String photoPreview = "/photoPreview";
  static const String login = "/login";
  static const String registrasi = "/registrasi";

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case news:
        final args = settings.arguments;
        return CustomRoutes(
          page: News(
            title: args,
          ),
          fullscreenDialog: true,
        );

      case location:
        final location = settings.arguments;
        return CustomRoutes(
          page: Location(
            location: location,
          ),
        );

      case newsDetail:
        BeritaModel args = settings.arguments;
        return CustomRoutes(
          page: NewsDetail(
            berita: args,
          ),
          fullscreenDialog: true,
        );

      case home:
        return CustomRoutes(page: Home());

      case jadwalKunjungan:
        return CustomRoutes(page: JadwalKunjungan());

      case layananPengaduan:
        return CustomRoutes(page: LayananPengaduan());

      case pengajuanIntegrasi:
        return CustomRoutes(page: PengajuanIntegrasi());

      case antrianOnline:
        return CustomRoutes(page: Antrian());

      case daftarAntrian:
        return CustomRoutes(page: DaftarAntrian());

      case strukturOrganisasi:
        return CustomRoutes(page: Struktur());

      case login:
        return CustomRoutes(page: Login());

      case registrasi:
        return CustomRoutes(page: Registrasi());

      case photoPreview:
        final Map<String, dynamic> params = settings.arguments;
        return CustomRoutes(
          page: PhotoPreview(
            galleryList: params['photo'],
            initialIndex: params['index'],
          ),
          fullscreenDialog: true,
        );

      case daftarAntrianDetail:
        AntrianModel args = settings.arguments;

        return CustomRoutes(page: DaftarAntrianDetail(args));

      default:
        return CustomRoutes(
          page: Scaffold(
            appBar: AppBar(
              title: Text("Not Found"),
            ),
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}

class CustomRoutes extends PageRouteBuilder {
  final Widget page;
  final bool fullscreenDialog;
  CustomRoutes({this.page, this.fullscreenDialog = false})
      : super(
          fullscreenDialog: fullscreenDialog,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
