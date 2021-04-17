import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/app_person_card.dart';
import 'package:silapis/widgets/widget.dart';

class JadwalKunjungan extends StatefulWidget {
  JadwalKunjungan({Key key}) : super(key: key);

  @override
  _JadwalKunjunganState createState() => _JadwalKunjunganState();
}

class _JadwalKunjunganState extends State<JadwalKunjungan> {
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

  List _loading() {
    return List.generate(4, (index) => index)
        .map((antrian) => AppJadwal(null))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(),
          title: 'Jadwal Kunjungan',
          context: context,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Umum',
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
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Khusus',
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
            _tabJadwalUmum(),
            _tabJadwalKhusus(),
          ],
        ),
      ),
    );
  }

  Widget _tabJadwalUmum() {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: Dimens.padding, horizontal: Dimens.padding),
      children: antrianList == null
          ? _loading()
          : antrianList.list.map((antrian) => AppJadwal(antrian)).toList(),
    );
  }

  Widget _tabJadwalKhusus() {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: Dimens.padding, horizontal: Dimens.padding),
      children: antrianList == null
          ? _loading()
          : antrianList.list.map((antrian) => AppJadwal(antrian)).toList(),
    );
  }
}
