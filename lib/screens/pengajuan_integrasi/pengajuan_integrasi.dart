import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/utils/launch_external.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';

class PengajuanIntegrasi extends StatefulWidget {
  PengajuanIntegrasi({Key key}) : super(key: key);

  @override
  _PengajuanIntegrasiState createState() => _PengajuanIntegrasiState();
}

class _PengajuanIntegrasiState extends State<PengajuanIntegrasi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(),
          title: 'Pengajuan Integrasi',
          context: context,
          bottom: AppTabBar.defaultTabBar(
            context: context,
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.solidAddressBook,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Persyaratan',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.cog,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Mekanisme',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _tabPersyaratan(),
            _tabMekanisme(),
          ],
        ),
      ),
    );
  }

  Widget _tabPersyaratan() {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: Dimens.padding, horizontal: Dimens.padding),
      children: [
        Text(
          'Persyaratan Integrasi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        AppListIconText(
          leading: Icon(
            Icons.file_copy,
            color: Colors.grey,
          ),
          content: 'Fotocopy KTP Penjamin',
        ),
        AppListIconText(
          leading: Icon(
            Icons.file_copy,
            color: Colors.grey,
          ),
          content: 'Fotocopy KK Penjamin',
        ),
        AppListIconText(
          leading: Icon(Icons.download_rounded,
              color: Theme.of(context).primaryColor),
          content: 'Surat Jaminan Keluarga',
          onTap: () {
            launchExternal('http://google.com');
          },
        ),
        AppListIconText(
          leading: Icon(Icons.download_rounded,
              color: Theme.of(context).primaryColor),
          content:
              'Surat Pernyataan Napi (Pidana Khusus Perkara PP No 99/Tahun 2021)',
          onTap: () {
            launchExternal('http://google.com');
          },
        ),
      ],
    );
  }

  Widget _tabMekanisme() {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: Dimens.padding, horizontal: Dimens.padding),
      children: [
        Text(
          'Mekanisme Pengajuan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        AppListIconText(
          leading: Text(
            '1',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content:
              'Keluarga warga binaan permasyarakatan mengunduh formulir dan file yang akan digunakan untuk pengajuan usulan',
        ),
        AppListIconText(
          leading: Text(
            '2',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content:
              'Keluarga warga binaan permasyarakatan mencetak dan mengisi formulir yang sudah di unduh serta melengkapi persyaratan yang diperlukan',
        ),
        AppListIconText(
          leading: Text(
            '3',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content:
              'Formulir yang sudah di isi dan syarat yang diperlukan dikirim melalui kantor pos terdekat ke alamat Lapas Kelas IIA Kalimantan Selatan : <b>Lapas Kelas IIA Kalimantan Selatan Jalan Kutilang No 10. Pamijen Banjarbaru - telpon/FAksimili (0219) 1092109210 / 182631263</b>',
        ),
        AppListIconText(
          leading: Text(
            '4',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content:
              'Melakukan Konfirmasi pengiriman ke nomor berikut <a href="tel:08121828182182">08121828182182</a> (Admin Layanan Integrasi Online)',
        ),
        AppListIconText(
          leading: Text(
            '5',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content:
              'Pihak Lapas melakukan pengecekan kelengkapan data pengajuan usulan dan akan diberikan konfirmasi melalui nomor yang sudah di isi formulir',
        ),
      ],
    );
  }
}
