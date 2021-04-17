import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    Future.delayed(Duration(seconds: 3)).then((value) => setState(() {
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
      title: Environment.APP_NAME,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'SourceSansPro'),
      onGenerateRoute: route.generateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: WillPopScope(
        child: isSplash ? SplashScreen() : Home(),
        onWillPop: onWillPop,
      ),
    );
  }

  DateTime currentBackPressTime;

  /// Function double tap back when close from apps
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tekan lagi untuk keluar aplikasi');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
