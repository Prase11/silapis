import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silapis/screens/screen.dart';
import 'app.dart';

void main() {
  runApp(App());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return Home();
  }
}
