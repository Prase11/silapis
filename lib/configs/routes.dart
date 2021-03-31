import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:silapis/screens/screen.dart';

class Routes {
  static const String home = "/home";
  static const String news = "/news";
  static const String newsDetail = "/newsDetail";

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case news:
        final args = settings.arguments;
        return CustomRoutes(
          page: News(
            title: args,
          ),
          fullscreenDialog: true,
        );

      case newsDetail:
        final args = settings.arguments;
        return CustomRoutes(
          page: NewsDetail(
            data: args,
          ),
          fullscreenDialog: true,
        );

      case home:
        return CustomRoutes(page: Home());

      default:
        return CustomRoutes(
          page: Scaffold(
            appBar: AppBar(
              title: Text("Not Found"),
            ),
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}

class CustomRoutes extends PageRouteBuilder {
  final Widget page;
  final bool fullscreenDialog;
  CustomRoutes({this.page, this.fullscreenDialog = false})
      : super(
          fullscreenDialog: fullscreenDialog,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}