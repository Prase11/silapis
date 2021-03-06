import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/utils/utils.dart';
import 'package:silapis/widgets/widget.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class SocialMedia extends StatelessWidget {
  final SosmedListModel sosmed;
  SocialMedia({Key key, @required this.sosmed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimens.padding),
      child: Column(
        children: [
          Text(
            'Follow Juga Sosial Media Kami',
            style: TextStyle(color: Colors.grey[50]),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sosmed.list
                .map(
                  (e) => _icon(
                    link: e.link,
                    icon: e.icon,
                    hexColor: e.warna,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _icon({String link, String icon, String hexColor = '#aabbcc'}) {
    IconData icons;

    switch (icon) {
      case 'whatsapp':
        icons = FontAwesomeIcons.whatsapp;
        break;
      case 'facebook':
        icons = FontAwesomeIcons.facebookF;
        break;
      case 'instagram':
        icons = FontAwesomeIcons.instagram;
        break;
      case 'youtube':
        icons = FontAwesomeIcons.youtube;
        break;
      default:
        icons = FontAwesomeIcons.question;
    }

    final Color color = HexColor.fromHex(hexColor);

    return InkWell(
        onTap: () {
          launchExternal(link);
        },
        child: LinearGradientMask(
          child: Container(
            margin: EdgeInsets.all(5),
            height: 40,
            width: 40,
            // child: Image.asset(Images.Logo),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icons, color: Colors.white),
            ),
          ),
        ));
  }
}
