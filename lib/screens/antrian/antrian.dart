import 'package:flutter/material.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';

class Antrian extends StatefulWidget {
  Antrian({Key key}) : super(key: key);

  @override
  _AntrianState createState() => _AntrianState();
}

class _AntrianState extends State<Antrian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Antrian',
        context: context,
      ),
      body: Text('ANTRIAN'),
    );
  }
}
