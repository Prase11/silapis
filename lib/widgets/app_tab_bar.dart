import 'package:flutter/material.dart';

class AppTabBar {
  static TabBar defaultTabBar(
      {@required BuildContext context,
      List<Widget> tabs,
      TabController controler}) {
    return TabBar(
      controller: controler,
      // isScrollable: true,
      indicatorColor: Theme.of(context).primaryColor,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(style: BorderStyle.none),
          bottom: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
              style: BorderStyle.solid),
          left: BorderSide(style: BorderStyle.none),
          right: BorderSide(style: BorderStyle.none),
        ),
        color: Colors.transparent,
      ),
      tabs: tabs,
    );
  }
}
