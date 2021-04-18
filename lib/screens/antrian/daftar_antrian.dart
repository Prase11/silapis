import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silapis/states/state_antrian.dart';
import 'package:silapis/widgets/widget.dart';

class DaftarAntrian extends StatelessWidget {
  DaftarAntrian({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AntrianState antrianState =
        Provider.of<AntrianState>(context, listen: true);

    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Daftar Antrian Anda',
        context: context,
      ),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: antrianState.refreshData,
            child: _buildContent(antrianState)),
      ),
    );
  }

  Widget _buildContent(AntrianState antrianState) {
    if (antrianState.error != null) {
      return AppError(
        title: antrianState.error['title'].toString(),
        message: antrianState.error['content'].toString(),
        image: antrianState.error['image'],
        onPress: () => antrianState.refreshData(),
        btnRefreshLoading: false,
      );
    } else if (antrianState.antrianList != null) {
      return ListView(
        children: antrianState.antrianList.list
            .map((antrian) => AppAntrianCard(antrian))
            .toList(),
      );
    } else {
      return _loading();
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
