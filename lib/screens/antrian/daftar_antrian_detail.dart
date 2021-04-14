import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:flutter/rendering.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class DaftarAntrianDetail extends StatefulWidget {
  final AntrianModel antrianModel;
  DaftarAntrianDetail(this.antrianModel, {Key key}) : super(key: key);

  @override
  _DaftarAntrianDetailState createState() => _DaftarAntrianDetailState();
}

class _DaftarAntrianDetailState extends State<DaftarAntrianDetail> {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(),
          title: 'Detail Tiket',
          context: context,
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.padding),
              child: InkWell(
                child: Icon(Icons.print),
                onTap: _printScreen,
              ),
            ),
          ]),
      body: ListView(children: [
        RepaintBoundary(
            key: _printKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'NOMOR ANTRIAN ANDA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '001',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
                ),
                Text(
                  'Nama Narapidana',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text('Tes Bin Nama Ayah'),
                SizedBox(height: 10),
                Text(
                  'Nama Pengunjung',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text('John Doe'),
                SizedBox(height: 20),
                Text(
                    'Dimohon Membawa Kartu Identitas atau Fotocopy Kartu Identitas'),
                Text('Waktu Kunjungan 09.00 - 12.00'),
              ],
            )),
      ]),
    );
  }
}
