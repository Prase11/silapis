import 'package:flutter/material.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/widget.dart';

class DaftarAntrian extends StatefulWidget {
  DaftarAntrian({Key key}) : super(key: key);

  @override
  _DaftarAntrianState createState() => _DaftarAntrianState();
}

class _DaftarAntrianState extends State<DaftarAntrian> {
  AntrianModel antrian = AntrianModel.fromJson({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Daftar Antrian Anda',
        context: context,
      ),
      body: ListView(
        children: [
          AppAntrianCard(antrian),
          AppAntrianCard(antrian),
          AppAntrianCard(antrian),
          AppAntrianCard(antrian),
          AppAntrianCard(antrian),
        ],
      ),
    );
  }
}
