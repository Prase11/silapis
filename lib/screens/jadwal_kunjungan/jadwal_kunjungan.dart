import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/repository/silaki.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';

class JadwalKunjungan extends StatefulWidget {
  JadwalKunjungan({Key key}) : super(key: key);

  @override
  _JadwalKunjunganState createState() => _JadwalKunjunganState();
}

class _JadwalKunjunganState extends State<JadwalKunjungan>
    with TickerProviderStateMixin {
  AntrianListModel antrianList;
  JadwalUmumListModel jadwalUmumList;
  JadwalKhususListModel jadwalKhususList;

  TabController _tabController;

  Future getData() async {
    final _jadwalUmum = await SilakiRepository.jadwalUmum();
    final _jadwalKhusus = await SilakiRepository.jadwalKhusus();
    if (_jadwalUmum.code == CODE.SUCCESS &&
        _jadwalKhusus.code == CODE.SUCCESS) {
      jadwalUmumList = JadwalUmumListModel.fromJson(_jadwalUmum.data);
      jadwalKhususList = JadwalKhususListModel.fromJson(_jadwalKhusus.data);
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();

    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);

    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  List _loading() {
    return List.generate(4, (index) => index)
        .map((antrian) => AppJadwalUmum(null))
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
            // controller: _tabController,
            // isScrollable: true,
            // indicatorColor: Theme.of(context).primaryColor,
            // labelColor: Theme.of(context).primaryColor,
            // unselectedLabelColor: Colors.grey,
            // indicatorSize: TabBarIndicatorSize.label,
            // indicator: BoxDecoration(
            //   border: Border(
            //     top: BorderSide(style: BorderStyle.none),
            //     bottom: BorderSide(
            //         color: Theme.of(context).primaryColor,
            //         width: 3,
            //         style: BorderStyle.solid),
            //     left: BorderSide(style: BorderStyle.none),
            //     right: BorderSide(style: BorderStyle.none),
            //   ),
            //   color: Colors.transparent,
            // ),
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
      children: jadwalUmumList == null
          ? _loading()
          : [
              Wrap(
                alignment: WrapAlignment.start,
                children: jadwalUmumList.list
                    .map((jadwal) => AppJadwalUmum(jadwal))
                    .toList(),
              )
            ],
    );
  }

  Widget _tabJadwalKhusus() {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: Dimens.padding, horizontal: Dimens.padding),
      children: jadwalKhususList == null
          ? _loading()
          : jadwalKhususList.list
              .map((jadwal) => AppJadwalKhusus(jadwal))
              .toList(),
    );
  }
}
