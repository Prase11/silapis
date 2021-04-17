import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/widget.dart';

class AppJadwalUmum extends StatelessWidget {
  final JadwalUmumModel jadwalModel;

  const AppJadwalUmum(
    this.jadwalModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (jadwalModel == null) {
      return Container(
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: AppSkeleton(),
      );
    }

    return Container(
        width: MediaQuery.of(context).size.width / 2.3,
        margin: const EdgeInsets.only(top: 7, bottom: 7, right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).cardColor.withOpacity(1)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.grey, width: 0.2),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.padding, vertical: Dimens.padding),
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              jadwalModel.hari,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pukul',
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(EvaIcons.clockOutline,
                                    size: 13,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color),
                                SizedBox(width: 2),
                                Text(
                                  "${jadwalModel.jamMulai} s.d ${jadwalModel.jamSelesai}",
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                  ])),
            ),
          ],
        ));
  }
}
