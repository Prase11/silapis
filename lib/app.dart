import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/screens/screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Routes route = Routes();
  bool isSplash = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) => setState(() {
          isSplash = false;
        }));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MaterialApp(
        title: 'LAPAS NARKOTIKA KALSEL',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: route.generateRoute,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: isSplash ? SplashScreen() : Home());
  }
}
