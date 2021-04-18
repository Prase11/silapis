import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';

enum ViewType { GRID, LIST }

class AppMenuBox extends StatelessWidget {
  final IconData icons;
  final Color color;
  // final String route;
  final String name;
  final String backgroundImage;
  final String keterangan;
  // final dynamic args;
  final ViewType viewType;
  final Function onTap;
  const AppMenuBox(
      {Key key,
      this.color,
      this.icons,
      this.name,
      // this.route,
      // this.args,
      this.backgroundImage,
      this.onTap,
      this.keterangan = '',
      this.viewType = ViewType.LIST})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewType == ViewType.LIST) {
      return _list(context);
    }

    return Container(
      width: 80,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.grey[100],
      ),
      child: Column(children: [
        Material(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LinearGradientMask(
                    child: Icon(
                      icons,
                      color: color,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }

  Widget _list(BuildContext context) {
    Color baseColor = Colors.white;

    return Container(
      width: double.infinity,
      height: 160,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                padding: EdgeInsets.all(Dimens.padding),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: baseColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 4,
                      child: Text(
                        keterangan,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: baseColor, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return RadialGradient(
          center: Alignment.center,
          radius: 3,
          colors: [
            Colors.white,
            Theme.of(context).primaryColor,
            Colors.white,
            Theme.of(context).primaryColor,
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
