import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silapis/states/state_antrian.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:silapis/configs/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DaftarAntrian extends StatelessWidget {
  DaftarAntrian({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AntrianKunjunganState antrianKunjunganState =
        Provider.of<AntrianKunjunganState>(context, listen: true);
    AntrianPenitipanState antrianPenitipanState =
        Provider.of<AntrianPenitipanState>(context, listen: true);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(),
          title: 'Daftar Antrian Anda',
          context: context,
          bottom: AppTabBar.defaultTabBar(
            context: context,
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.userFriends,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Kunjungan',
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
                      FontAwesomeIcons.gifts,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Penitipan',
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
            SafeArea(
              child: RefreshIndicator(
                onRefresh: antrianKunjunganState.refreshData,
                child: FadeAnimation(
                    0.5, _buildContentKunjungan(antrianKunjunganState)),
              ),
            ),
            SafeArea(
              child: RefreshIndicator(
                  onRefresh: antrianPenitipanState.refreshData,
                  child: FadeAnimation(
                      0.5, _buildContentPenitipan(antrianPenitipanState))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentKunjungan(AntrianKunjunganState antrianKunjunganState) {
    if (antrianKunjunganState.error != null) {
      return AppError(
        title: antrianKunjunganState.error['title'].toString(),
        message: antrianKunjunganState.error['content'].toString(),
        image: antrianKunjunganState.error['image'],
        onPress: () => antrianKunjunganState.refreshData(),
        btnRefreshLoading: false,
      );
    } else if (antrianKunjunganState.antrianList == null) {
      return _loading();
    } else if (antrianKunjunganState.isEmpty) {
      return Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            AppInfo(
              title: 'Antrian Kunjungan Kosong',
              message: 'Tidak ada antrian pada hari ini',
              image: Images.Empty,
            )
          ],
        ),
      );
    } else {
      return ListView(
        children: antrianKunjunganState.antrianList.list
            .map((antrian) => AppAntrianCard(antrian))
            .toList(),
      );
    }
  }

  Widget _buildContentPenitipan(AntrianPenitipanState antrianPenitipanState) {
    if (antrianPenitipanState.error != null) {
      return AppError(
        title: antrianPenitipanState.error['title'].toString(),
        message: antrianPenitipanState.error['content'].toString(),
        image: antrianPenitipanState.error['image'],
        onPress: () => antrianPenitipanState.refreshData(),
        btnRefreshLoading: false,
      );
    } else if (antrianPenitipanState.antrianList == null) {
      return _loading();
    } else if (antrianPenitipanState.isEmpty) {
      return Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            AppInfo(
              title: 'Antrian Penitipan Kosong',
              message: 'Tidak ada antrian pada hari ini',
              image: Images.Empty,
            )
          ],
        ),
      );
    } else {
      return ListView(
        children: antrianPenitipanState.antrianList.list
            .map((antrian) => AppAntrianCard(antrian))
            .toList(),
      );
    }
  }

  Widget _loading() {
    return ListView(
      children: List.generate(4, (index) => index)
          .map((antrian) => AppAntrianCard(null))
          .toList(),
    );
  }
}
