import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';

class LayananPengaduan extends StatefulWidget {
  LayananPengaduan({Key key}) : super(key: key);

  @override
  _LayananPengaduanState createState() => _LayananPengaduanState();
}

class _LayananPengaduanState extends State<LayananPengaduan> {
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
          AppMyButton(
            onPress: () {},
            icon: FontAwesomeIcons.whatsapp,
            loading: false,
            text: 'Whatsapp',
            buttonColor: Colors.green,
          ),
          SizedBox(height: 20),
          AppMyButton(
            onPress: () {},
            icon: FontAwesomeIcons.fileAlt,
            loading: false,
            text: 'Google Form',
            buttonColor: Colors.blue,
          ),
          SizedBox(height: 20),
          AppMyButton(
            onPress: () {},
            icon: FontAwesomeIcons.phoneAlt,
            loading: false,
            text: '0821-1902-1892',
            buttonColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
