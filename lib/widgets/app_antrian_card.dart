import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:dotted_border/dotted_border.dart';

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
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).cardColor.withOpacity(1)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200], width: 0.5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[100], blurRadius: 0.5, offset: Offset(2, 2)),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.daftarAntrianDetail, arguments: antrianModel);
          },
          child: Stack(
            children: [
              Positioned(
                  bottom: 20,
                  right: 20,
                  child: Icon(
                    FontAwesomeIcons.ticketAlt,
                    size: 40,
                    color: Colors.grey[200],
                  )),
              DottedBorder(
                strokeWidth: 2,
                color: Colors.grey.withOpacity(.5),
                borderType: BorderType.RRect,
                dashPattern: [4, 4],
                radius: Radius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        antrianModel.no,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.grey[800]),
                      ),
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
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            SizedBox(height: 5),
                            Text(
                              'WBP: ${antrianModel.napi.nama}',
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
            ],
          ),
        ),
      ),
    );
  }
}
