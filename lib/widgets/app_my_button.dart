import 'package:flutter/material.dart';

class AppMyButton extends StatelessWidget {
  final bool loading;
  final String text;
  final Function onPress;
  final IconData icon;
  final Color buttonColor;

  const AppMyButton(
      {Key key,
      @required this.loading,
      this.icon,
      this.text,
      this.onPress,
      this.buttonColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            buttonColor ?? Theme.of(context).primaryColor,
            buttonColor != null
                ? buttonColor.withOpacity(.6)
                : Theme.of(context).primaryColor.withOpacity(.6),
          ])),
      child: InkWell(
        onTap: loading ? null : onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) ...[
              SizedBox(
                height: 16.0,
                width: 16.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            ],
            // !loading
            //     ? Icon(
            //         icon,
            //         color: Colors.white,
            //       )
            //     : SizedBox(
            //         height: 16.0,
            //         width: 16.0,
            //         child: CircularProgressIndicator(
            //           strokeWidth: 2.5,
            //           valueColor: AlwaysStoppedAnimation(Colors.white),
            //         ),
            //       ),
            SizedBox(width: 10),
            Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
