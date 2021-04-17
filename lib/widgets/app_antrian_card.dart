import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/widget.dart';

class AppAntrianCard extends StatelessWidget {
  final Function onTap;
  final AntrianModel antrianModel;
  const AppAntrianCard(this.antrianModel, {Key key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (antrianModel == null) {
      return Container(
        width: 110,
        height: 90,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: Dimens.padding),
        child: AppSkeleton(),
      );
    }

    return Container(
      width: 110,
      height: 90,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: Dimens.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      child: Material(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.daftarAntrianDetail, arguments: antrianModel);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Text(antrianModel.no,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(antrianModel.pengunjung.nama,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(antrianModel.humanDate(),
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700])),
                      SizedBox(height: 5),
                      Text(
                        'WBP: Nama ${antrianModel.pengunjung.namaWbp} Bin ${antrianModel.pengunjung.namaAyah}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
