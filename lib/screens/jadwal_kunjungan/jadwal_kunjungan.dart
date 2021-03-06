import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/states/state.dart';
import 'package:provider/provider.dart';

class JadwalKunjungan extends StatelessWidget {
  JadwalKunjungan({Key key}) : super(key: key);

  Widget _loading() {
    return ListView(
        children: List.generate(4, (index) => index)
            .map((antrian) => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Dimens.padding, vertical: Dimens.padding / 4),
                  child: AppJadwalUmum(null),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = DefaultTabController.of(context);
    JadwalUmumState jadwalUmumState =
        Provider.of<JadwalUmumState>(context, listen: true);
    JadwalKhususState jadwalKhususState =
        Provider.of<JadwalKhususState>(context, listen: true);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(),
          title: 'Jadwal Kunjungan',
          context: context,
          bottom: AppTabBar.defaultTabBar(
            context: context,
            controler: _tabController,
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
            _tabJadwalUmum(jadwalUmumState),
            _tabJadwalKhusus(jadwalKhususState),
          ],
        ),
      ),
    );
  }

  Widget _tabJadwalUmum(JadwalUmumState jadwalUmumState) {
    return RefreshIndicator(
        onRefresh: jadwalUmumState.refreshData,
        child: FadeAnimation(0.5, _buildContentJadwalUmum(jadwalUmumState)));
  }

  Widget _tabJadwalKhusus(JadwalKhususState jadwalKhususState) {
    return RefreshIndicator(
        onRefresh: jadwalKhususState.refreshData,
        child:
            FadeAnimation(0.5, _buildContentJadwalKhusus(jadwalKhususState)));
  }

  Widget _buildContentJadwalUmum(JadwalUmumState jadwalUmumState) {
    if (jadwalUmumState.error != null) {
      return AppError(
        title: jadwalUmumState.error['title'].toString(),
        message: jadwalUmumState.error['content'].toString(),
        image: jadwalUmumState.error['image'],
        onPress: () => jadwalUmumState.refreshData(),
        btnRefreshLoading: false,
      );
    } else if (jadwalUmumState.data != null) {
      return ListView(
          padding: EdgeInsets.symmetric(
              vertical: Dimens.padding, horizontal: Dimens.padding),
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: jadwalUmumState.data.list
                  .map((jadwal) => AppJadwalUmum(jadwal))
                  .toList(),
            )
          ]);
    } else {
      return _loading();
    }
  }

  Widget _buildContentJadwalKhusus(JadwalKhususState jadwalKhususState) {
    if (jadwalKhususState.error != null) {
      return AppError(
        title: jadwalKhususState.error['title'].toString(),
        message: jadwalKhususState.error['content'].toString(),
        image: jadwalKhususState.error['image'],
        onPress: () => jadwalKhususState.refreshData(),
        btnRefreshLoading: false,
      );
    } else if (jadwalKhususState.data != null) {
      return ListView(
          padding: EdgeInsets.symmetric(
              vertical: Dimens.padding, horizontal: Dimens.padding),
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: jadwalKhususState.data.list
                  .map((jadwal) => AppJadwalKhusus(jadwal))
                  .toList(),
            )
          ]);
    } else {
      return _loading();
    }
  }
}
