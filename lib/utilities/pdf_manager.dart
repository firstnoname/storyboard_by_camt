import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:storyboard_camt/models/storyboard.dart';
import 'package:storyboard_camt/models/user.dart';

class PdfManager {
  static Future<File> generatePDFTest() async {
    final pdf = pw.Document();

    final headers = ['iFirst', '31'];

    final users = [
      User(firstName: 'James', lastName: 'Bones'),
      User(firstName: 'Emma', lastName: 'Watson'),
    ];

    final data = users.map((user) => [user.firstName, user.lastName]).toList();

    pdf.addPage(pw.Page(
      build: (context) => pw.Table.fromTextArray(headers: headers, data: data),
    ));

    return saveDocument(name: 'test_pdf.pdf', pdf: pdf);
  }

  static Future<File> generatePDF(StoryboardModel storyboardData) async {
    final font = await rootBundle.load("assets/fonts/THSarabun.ttf");

    final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();

    final image = pw.MemoryImage(
      File(storyboardData.storyList!.first.imagePath!).readAsBytesSync(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            height: double.infinity,
            width: double.infinity,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: storyboardData.storyList!
                  .map(
                    (e) => pw.Padding(
                        padding: pw.EdgeInsets.symmetric(vertical: 8),
                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Image(
                                pw.MemoryImage(
                                  File(e.imagePath!).readAsBytesSync(),
                                ),
                                height: 200,
                                width: 200),
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: pw.Table(
                                children: [
                                  pw.TableRow(
                                    children: [
                                      pw.Text(
                                        ' วินาทีที่ : ${e.duration.toString()}',
                                        style: pw.TextStyle(font: ttf),
                                      )
                                    ],
                                  ),
                                  pw.TableRow(
                                    children: [
                                      pw.Text(
                                        ' คำอธิบาย : ${e.description.toString()}',
                                        style: pw.TextStyle(font: ttf),
                                      )
                                    ],
                                  ),
                                  pw.TableRow(
                                    children: [
                                      pw.Text(
                                        ' ข้อมูลเสียง : ${e.soundSource.toString()}',
                                        style: pw.TextStyle(font: ttf),
                                      )
                                    ],
                                  ),
                                  pw.TableRow(
                                    children: [
                                      pw.Text(
                                        ' วินาทีของเสียง : ${e.soundDuration.toString()}',
                                        style: pw.TextStyle(font: ttf),
                                      )
                                    ],
                                  ),
                                  pw.TableRow(
                                    children: [
                                      pw.Text(
                                        ' สถานที่ : ${e.place.toString()}',
                                        style: pw.TextStyle(font: ttf),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );

    return saveDocument(name: '${storyboardData.projectName}.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
