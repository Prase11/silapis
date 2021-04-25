import 'package:flutter/material.dart';
import 'package:silapis/configs/config.dart';
import 'package:silapis/models/model.dart';
import 'package:silapis/widgets/app_custom_appbar.dart';
import 'package:flutter/rendering.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:silapis/widgets/widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

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
      backgroundColor: Colors.grey[100],
      appBar: AppCustomAppBar.defaultAppBar(
          leading: BackButton(),
          title: 'Detail Tiket ${widget.antrianModel.jenis}',
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
      body: FadeAnimation(
        0.5,
        ListView(children: [
          ClipPath(
            clipper: MovieTicketClipper(),
            child: Container(
              margin: EdgeInsets.all(Dimens.padding * 1.5),
              padding: EdgeInsets.all(Dimens.padding * 1),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: RepaintBoundary(
                key: _printKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.antrianModel.humanDate(),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          "ID ANTRIAN : ${widget.antrianModel.id}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    _myDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama Pengunjung',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(widget.antrianModel.pengunjung.nama),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'NIK',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(widget.antrianModel.nik),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Keterangan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(widget.antrianModel.keterangan),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'NOMOR ANTRIAN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                widget.antrianModel.no,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _myDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Narapidana',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            '${widget.antrianModel.napi.nama}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Blok Kamar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            '${widget.antrianModel.napi.blokKamar}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No Registrasi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            '${widget.antrianModel.napi.noReg}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UU',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            '${widget.antrianModel.napi.uu}',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    _myDivider(),
                    Center(
                      child: Column(
                        children: [
                          Text(
                              'Waktu Kunjungan ${widget.antrianModel.createdAt}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 20),

                          PrettyQr(
                              // image: AssetImage(Images.Logo),
                              typeNumber: 3,
                              size: 200,
                              data: widget.antrianModel.id,
                              errorCorrectLevel: QrErrorCorrectLevel.M,
                              roundEdges: true),
                          // SizedBox(height: 10),
                          // Text('${widget.antrianModel.id}',
                          //     style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: Dimens.padding * 1.5,
                right: Dimens.padding * 1.5,
                left: Dimens.padding * 1.5),
            child: Text(
                '* Dimohon Membawa Kartu Identitas atau Fotocopy Kartu Identitas',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
          ),
        ]),
      ),
    );
  }

  Widget _myDivider() {
    return Column(
      children: [SizedBox(height: 10), Divider(), SizedBox(height: 10)],
    );
  }
}
