import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';

class LayananPengaduan extends StatefulWidget {
  LayananPengaduan({Key key}) : super(key: key);

  @override
  _LayananPengaduanState createState() => _LayananPengaduanState();
}

class _LayananPengaduanState extends State<LayananPengaduan> {
  LayananPengaduanListModel layananPengaduan;

  Future getData() async {
    final _layananPengaduan = await SilakiRepository.layananPengaduan();
    if (_layananPengaduan.code == CODE.SUCCESS) {
      layananPengaduan =
          LayananPengaduanListModel.fromJson(_layananPengaduan.data);
      UtilLogger.log('DATA', layananPengaduan.list.map((e) => e.toJson()));

      setState(() {});
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
        title: 'Layanan Pengaduan',
        context: context,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
        children: [
          Text(
            'Tujuan Layanan pengaduan bagi masyarakat yang ingin menyampaikan keluhan dan saran terkait layanan kunjungan dan pelayanan publik lainnya yang ada di lapas kelas II A Kalimantan Selatan. Masyarakat dapat menyampaikankeluhan/aduan dan saran melalui website ini sebagai bentuk akuntabilitas, transparantasi dan profesionalisme petugas lapas ',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            'Beberapa Jenis Layanan aduan / saran yang kami sediakan : ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          SizedBox(height: 20),
          if (layananPengaduan != null) ...[
            Column(
              children: layananPengaduan.list
                  .map(
                    (layanan) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                      child: AppMyButton(
                          onPress: () {
                            launchExternal(layanan.link);
                          },
                          icon: layanan.icon,
                          loading: false,
                          text: layanan.nama,
                          buttonColor: layanan.color),
                    ),
                  )
                  .toList(),
            ),
          ] else ...[
            Column(
              children: List.generate(3, (index) => index)
                  .map(
                    (layanan) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                      child: AppMyButton(
                          icon: Icons.local_dining,
                          loading: true,
                          text: 'Memuat Layanan ...',
                          buttonColor: Colors.green),
                    ),
                  )
                  .toList(),
            ),
          ]
        ],
      ),
    );
  }
}
