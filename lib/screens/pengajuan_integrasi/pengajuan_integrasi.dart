import 'package:flutter/material.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';

class PengajuanIntegrasi extends StatefulWidget {
  PengajuanIntegrasi({Key key}) : super(key: key);

  @override
  _PengajuanIntegrasiState createState() => _PengajuanIntegrasiState();
}

class _PengajuanIntegrasiState extends State<PengajuanIntegrasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Pengajuan Integrasi',
        context: context,
      ),
      body: Text('Pengajuan Integrasi'),
    );
  }
}
