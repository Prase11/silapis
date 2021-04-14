import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:silapis/widgets/widget.dart';

class Antrian extends StatefulWidget {
  Antrian({Key key}) : super(key: key);

  @override
  _AntrianState createState() => _AntrianState();
}

class _AntrianState extends State<Antrian> {
  final _nomorPonsel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
        leading: BackButton(),
        title: 'Antrian Online',
        context: context,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
        children: [
          Text(
            'Detail Pengunjung',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          ///NIK
          AppTextInput(
            title: 'NIK',
            hintText: 'Nomor Induk Keluarga',
            errorText: '',
            textInputAction: TextInputAction.next,
            onTapIcon: () async {},
            onChanged: (text) {},
            icon: Icon(Icons.clear),
            controller: _nomorPonsel,
          ),

          ///Nama Pengunjung
          AppTextInput(
            title: 'Nama Pengunjung',
            hintText: 'Nama Pengunjung',
            errorText: '',
            textInputAction: TextInputAction.next,
            onTapIcon: () async {},
            onChanged: (text) {},
            icon: Icon(Icons.clear),
            controller: _nomorPonsel,
          ),

          SizedBox(height: 20),
          Text(
            'Detail Warga Binaan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          ///NIK
          AppTextInput(
            title: 'Nama WBP',
            hintText: 'Nomor Induk Keluarga',
            errorText: '',
            textInputAction: TextInputAction.next,
            onTapIcon: () async {},
            onChanged: (text) {},
            icon: Icon(Icons.clear),
            controller: _nomorPonsel,
          ),

          ///Nama Pengunjung
          AppTextInput(
            title: 'Bin',
            hintText: 'Nama Pengunjung',
            errorText: '',
            textInputAction: TextInputAction.next,
            onTapIcon: () async {},
            onChanged: (text) {},
            icon: Icon(Icons.clear),
            controller: _nomorPonsel,
          ),

          SizedBox(height: 20),
          // BUTTON
          OutlineButton(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      'Proses Antrian',
                      style: TextStyle(
                          color: Color(0xff27AE60),
                          fontWeight: FontWeight.bold),
                    ))),
              ),
              borderSide: BorderSide(color: Color(0xff27AE60)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Colors.white,
              onPressed: () {}),
        ],
      ),
    );
  }
}
