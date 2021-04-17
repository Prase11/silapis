import 'package:flutter/material.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/logger.dart';
import 'package:silapis/widgets/widget.dart';

class DaftarAntrian extends StatefulWidget {
  DaftarAntrian({Key key}) : super(key: key);

  @override
  _DaftarAntrianState createState() => _DaftarAntrianState();
}

class _DaftarAntrianState extends State<DaftarAntrian> {
  AntrianListModel antrianList;

  Future getData() async {
    final data = await SilakiRepository.getAntrian();
    if (data.code == CODE.SUCCESS) {
      antrianList = AntrianListModel.fromJson(data.data);
      setState(() {});
      UtilLogger.log('DATA', antrianList.list.map((e) => e.toJson()));
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
        title: 'Daftar Antrian Anda',
        context: context,
      ),
      body: antrianList == null
          ? _loading()
          : ListView(
              children: antrianList.list
                  .map((antrian) => AppAntrianCard(antrian))
                  .toList(),
            ),
    );
  }

  Widget _loading() {
    return ListView(
      children: List.generate(4, (index) => index)
          .map((antrian) => AppAntrianCard(null))
          .toList(),
    );
  }
}
