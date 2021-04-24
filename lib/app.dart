import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/screens/screen.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:silapis/states/state.dart';

class App extends StatelessWidget {
  final Routes route = Routes();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Theme.of(context).primaryColorBrightness));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationState()),
        ChangeNotifierProvider(create: (_) => AntrianKunjunganState()),
        ChangeNotifierProvider(create: (_) => AntrianPenitipanState()),
        ChangeNotifierProvider(create: (_) => LayananState()),
        ChangeNotifierProvider(create: (_) => JadwalUmumState()),
        ChangeNotifierProvider(create: (_) => JadwalKhususState()),
        ChangeNotifierProvider(create: (_) => NapiState()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: MaterialApp(
          title: Environment.APP_NAME,
          theme: Style.getTheme(font: 'SourceSansPro', isLight: true),
          onGenerateRoute: route.generateRoute,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: WillPopScope(
            child: Consumer<ApplicationState>(
              builder: (context, percentDone, child) {
                return context.watch<ApplicationState>().isSplash
                    ? SplashScreen()
                    : Home();
              },
            ),
            // child: Provider<ApplicationState>(
            //     create: (_) => ApplicationState(),
            //     // we use `builder` to obtain a new `BuildContext` that has access to the provider
            //     builder: (context, _) {
            //       // No longer throws
            //       return context.watch<ApplicationState>().isSplash
            //           ? SplashScreen()
            //           : Home();
            //     }),

            // child: context.watch<ApplicationState>().isSplash
            //     ? SplashScreen()
            //     : Home(),
            onWillPop: onWillPop,
          ),
        ),
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
