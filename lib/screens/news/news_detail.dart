import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:html/dom.dart' as dom;
import 'package:silapis/configs/config.dart';
import 'package:silapis/utils/utils.dart';

class NewsDetail extends StatelessWidget {
  final BeritaModel berita;
  const NewsDetail({Key key, this.berita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(),
          title: 'Detail',
          context: context,
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: berita.gambar,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.photoPreview,
                          arguments: {
                            'index': 0,
                            'photo': [
                              ImageModel(0, berita.gambar, berita.judul)
                            ]
                          });
                    }),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.all(Dimens.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        berita.judul,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        unixTimeStampToDateTime(
                            berita.tanggal.millisecondsSinceEpoch),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(Dimens.padding),
                  child: Html(
                      data: berita.konten,
                      defaultTextStyle: TextStyle(
                        fontSize: 15.0,
                      ),
                      customTextAlign: (dom.Node node) {
                        return TextAlign.left;
                      },
                      onLinkTap: (url) {
                        // launchExternal(url);
                      },
                      customTextStyle: (dom.Node node, TextStyle baseStyle) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "p":
                              return baseStyle.merge(TextStyle(height: 1.3));
                          }
                        }
                        return baseStyle;
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
