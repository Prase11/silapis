import 'package:flutter/material.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';

class JadwalKunjungan extends StatefulWidget {
  JadwalKunjungan({Key key}) : super(key: key);

  @override
  _JadwalKunjunganState createState() => _JadwalKunjunganState();
}

class _JadwalKunjunganState extends State<JadwalKunjungan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Jadwal Kunjungan',
        context: context,
      ),
      body: Text('Jadwal Kunjungan'),
    );
  }
}
