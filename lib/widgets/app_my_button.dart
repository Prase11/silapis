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
    return SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Theme.of(context).primaryColor;
                return buttonColor; // Use the component's default.
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          onPressed: loading ? null : onPress,
          label: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          icon: !loading
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : SizedBox(
                  height: 16.0,
                  width: 16.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )),
        ));
  }
}
