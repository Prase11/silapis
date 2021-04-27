import 'package:flutter/material.dart';
import 'package:silapis/states/state.dart';
import 'package:silapis/screens/screen.dart';

class PengajuanIntegrasi extends StatelessWidget {
  PengajuanIntegrasi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: true);
    print('BUILD PEGAJUAN');
    return authState.isLogged ? PengajuanIntegrasiHome(authState) : Login();
  }
}
