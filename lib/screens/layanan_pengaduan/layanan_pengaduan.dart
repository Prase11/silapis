import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:provider/provider.dart';
import 'package:silapis/states/state.dart';

class LayananPengaduan extends StatelessWidget {
  LayananPengaduan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayananState layananState =
        Provider.of<LayananState>(context, listen: true);

    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(), title: 'Layanan Pengaduan', context: context),
      body: RefreshIndicator(
        onRefresh: layananState.refreshData,
        child: FadeAnimation(
          0.5,
          ListView(
            padding: EdgeInsets.all(Dimens.padding),
            children: [
              Text(
                'Tujuan Layanan pengaduan bagi masyarakat yang ingin menyampaikan keluhan dan saran terkait layanan kunjungan dan pelayanan publik lainnya yang ada di Lapas Karangintan kelas II A Kalimantan Selatan. Masyarakat dapat menyampaikan keluhan/aduan dan saran melalui website ini sebagai bentuk akuntabilitas, transparantasi dan profesionalisme petugas lapas ',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Beberapa Jenis Layanan aduan / saran yang kami sediakan : ',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(height: 20),
              _buildContent(context, layananState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, LayananState layananState) {
    if (layananState.error != null) {
      return AppError(
        title: layananState.error['title'].toString(),
        message: layananState.error['content'].toString(),
        image: layananState.error['image'],
        onPress: () => layananState.refreshData(),
        btnRefreshLoading: false,
      );
    } else if (layananState.layananPengaduanList != null) {
      return Wrap(
        alignment: WrapAlignment.center,
        children: layananState.layananPengaduanList.list
            .map(
              (layanan) => AppMenuBox(
                backgroundImage:
                    'https://mcdn.wallpapersafari.com/medium/65/86/3m6AIX.jpg',
                keterangan: '-',
                viewType: ViewType.GRID,
                name: layanan.nama,
                icons: layanan.icon,
                textColor: Colors.black,
                color: Theme.of(context).primaryColor,
                onTap: () {
                  launchExternal(layanan.link);
                },
              ),
            )
            .toList(),
      );
    } else {
      return Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(3, (index) => index)
            .map(
              (layanan) => AppSkeleton(
                width: 60,
                height: 60,
                margin: 10,
                padding: 10,
              ),
            )
            .toList(),
      );
    }
  }
}
