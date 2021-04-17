import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/widget.dart';

class AppPersonCard extends StatelessWidget {
  final Function onTap;
  final AntrianModel personModel;
  const AppPersonCard(this.personModel, {Key key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (personModel == null) {
      return Container(
        width: 110,
        height: 120,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: Dimens.padding),
        child: AppSkeleton(),
      );
    }

    return Container(
      width: 110,
      height: 120,
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
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://mcdn.wallpapersafari.com/medium/46/34/Mxjr2p.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text('John Doe',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text('1611016210001',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700])),
                      Text('1611016210001',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700])),
                      Text('Laki-Laki',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700])),
                      SizedBox(height: 5),
                      Text(
                        'WBP: Nama ${personModel.pengunjung.namaWbp} Bin ${personModel.pengunjung.namaAyah}',
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
