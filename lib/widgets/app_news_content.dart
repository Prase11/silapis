import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/utils/format_date.dart';
import 'package:silapis/widgets/widget.dart';

class AppNewsContent extends StatelessWidget {
  final Function onTap;
  final String image;
  final String judul;
  final DateTime tanggal;
  const AppNewsContent(
      {Key key, this.image, this.onTap, this.judul, this.tanggal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (judul == null && tanggal == null) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSkeleton(
              height: 220,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeleton(
                    margin: 5,
                    height: 20,
                  ),
                  AppSkeleton(
                    margin: 5,
                    height: 20,
                  ),
                  AppSkeleton(
                    margin: 5,
                    height: 15,
                    width: 70,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: Dimens.padding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    unixTimeStampToDateTime(tanggal.millisecondsSinceEpoch),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
