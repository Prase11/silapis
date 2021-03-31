import 'package:flutter/material.dart';

class AppMenuBox extends StatelessWidget {
  final IconData icons;
  final Color color;
  final String route;
  final String name;
  const AppMenuBox({Key key, this.color, this.icons, this.name, this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Material(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (route != null) {
              Navigator.pushNamed(context, route, arguments: name);
              print('LOG');
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icons,
                  color: color,
                  size: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
