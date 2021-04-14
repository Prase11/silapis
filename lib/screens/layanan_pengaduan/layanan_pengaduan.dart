import 'package:flutter/material.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';

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
      body: Text('Layanan Pengaduan'),
    );
  }
}
