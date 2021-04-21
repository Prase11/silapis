import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/states/state.dart';
import 'package:silapis/widgets/widget.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class CariLapas extends StatefulWidget {
  CariLapas({Key key}) : super(key: key);

  @override
  _CariLapasState createState() {
    return _CariLapasState();
  }
}

class _CariLapasState extends State<CariLapas> {
  final _textLanguageController = TextEditingController();
  DateTime delayedSearch;

  ///On change language
  Future<void> _selectData(NapiModel napi) async {
    Navigator.pop(context, napi);
  }

  @override
  Widget build(BuildContext context) {
    NapiState napiState = Provider.of<NapiState>(context, listen: true);
    final _debouncer = Debouncer(milliseconds: 500);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cari Data'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
                bottom: 15,
              ),
              child: AppTextInput(
                hintText: 'Cari',
                icon: Icon(Icons.clear),
                controller: _textLanguageController,
                onChanged: (str) {
                  // if(str.length)
                  _debouncer.run(() {
                    if (str.length > 2) {
                      napiState.findData(str);
                    } else if (str.length == 0) {
                      napiState.findData(str);
                    }
                  });
                },
                onSubmitted: (str) {},
                onTapIcon: () async {
                  napiState.findData('');
                  _textLanguageController.clear();
                },
              ),
            ),
            if (napiState.napiList == null) ...[
              SizedBox(
                height: 100,
              ),
              Text('Cari DATA'),
            ] else if (napiState.isLoading) ...[
              SizedBox(
                height: 100,
              ),
              Center(
                child: CupertinoActivityIndicator(),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context, index) {
                    final item = napiState.napiList.list[index];
                    return AppListTitle(
                      title: item.nama,
                      onPressed: () {
                        _selectData(item);
                        napiState.findData('');
                      },
                    );
                  },
                  itemCount: napiState.napiList.list.length ?? 0,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
