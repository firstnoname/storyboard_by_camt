import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:storyboard_camt/models/storyboard.dart';
import 'package:storyboard_camt/models/user.dart';
import 'package:storyboard_camt/utilities/constants.dart';

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
    final camtLogo =
        (await rootBundle.load(defaultCamtVerticalJPG)).buffer.asUint8List();

    final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();

    pdf.addPage(MultiPage(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: CrossAxisAlignment.start,
        header: (Context context) {
          if (context.pageNumber == 1) {
            return pw.Container();
          }
          return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            // decoration: const BoxDecoration(
            //     border:
            //         BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text(
              '${storyboardData.author?.displayName ?? ''}',
              style: Theme.of(context)
                  .defaultTextStyle
                  .copyWith(color: PdfColors.grey),
            ),
          );
        },
        footer: (Context context) {
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                  style: Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (Context context) => <Widget>[
              Header(
                level: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${storyboardData.projectName}',
                        style: pw.TextStyle(font: ttf), textScaleFactor: 2),
                    Image(
                      pw.MemoryImage(camtLogo),
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: storyboardData.storyList!
                    .map(
                      (e) => pw.Table(
                        border: pw.TableBorder(
                          top: pw.BorderSide(),
                          bottom: pw.BorderSide(),
                          right: pw.BorderSide(),
                          left: pw.BorderSide(),
                        ),
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Padding(
                                    padding:
                                        pw.EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      'ลำดับที่ ${int.parse(e.keyIndex!) + 1}',
                                      style: pw.TextStyle(font: ttf),
                                    ),
                                  ),
                                  pw.Container(
                                      color: PdfColors.black,
                                      width: 1,
                                      height: 150),
                                  Container(
                                    padding:
                                        pw.EdgeInsets.symmetric(horizontal: 8),
                                    height: 150,
                                    width: 200,
                                    child: pw.Center(
                                      child: pw.Image(
                                        pw.MemoryImage(
                                          File(e.imagePath!).readAsBytesSync(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                      color: PdfColors.black,
                                      width: 1,
                                      height: 150),
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
                                  // pw.Expanded(
                                  //   child: pw.Column(
                                  //       children: [pw.Text('Sheet 01')]),
                                  // ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                    .toList(),
              )
            ]));

    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (context) {
    //       return pw.Container(
    //         height: double.infinity,
    //         width: double.infinity,
    //         child: pw.Column(
    //           crossAxisAlignment: pw.CrossAxisAlignment.start,
    //           mainAxisAlignment: pw.MainAxisAlignment.start,
    //           children: storyboardData.storyList!
    //               .map(
    //                 (e) => pw.Table(
    //                   border: pw.TableBorder(
    //                     top: pw.BorderSide(),
    //                     bottom: pw.BorderSide(),
    //                     right: pw.BorderSide(),
    //                     left: pw.BorderSide(),
    //                   ),
    //                   children: [
    //                     pw.TableRow(
    //                       children: [
    //                         pw.Padding(
    //                           padding: pw.EdgeInsets.symmetric(
    //                               vertical: 8, horizontal: 8),
    //                           child: pw.Row(
    //                             crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                             children: [
    //                               pw.Image(
    //                                 pw.MemoryImage(
    //                                   File(e.imagePath!).readAsBytesSync(),
    //                                 ),
    //                                 height: 200,
    //                                 width: 200,
    //                               ),
    //                               pw.Padding(
    //                                 padding: pw.EdgeInsets.symmetric(
    //                                     vertical: 8, horizontal: 24),
    //                                 child: pw.Table(
    //                                   // border: pw.TableBorder(
    //                                   //   top: pw.BorderSide(),
    //                                   //   bottom: pw.BorderSide(),
    //                                   //   right: pw.BorderSide(),
    //                                   //   left: pw.BorderSide(),
    //                                   // ),
    //                                   children: [
    //                                     pw.TableRow(
    //                                       children: [
    //                                         pw.Text(
    //                                           ' วินาทีที่ : ${e.duration.toString()}',
    //                                           style: pw.TextStyle(font: ttf),
    //                                         )
    //                                       ],
    //                                     ),
    //                                     pw.TableRow(
    //                                       children: [
    //                                         pw.Text(
    //                                           ' คำอธิบาย : ${e.description.toString()}',
    //                                           style: pw.TextStyle(font: ttf),
    //                                         )
    //                                       ],
    //                                     ),
    //                                     pw.TableRow(
    //                                       children: [
    //                                         pw.Text(
    //                                           ' ข้อมูลเสียง : ${e.soundSource.toString()}',
    //                                           style: pw.TextStyle(font: ttf),
    //                                         )
    //                                       ],
    //                                     ),
    //                                     pw.TableRow(
    //                                       children: [
    //                                         pw.Text(
    //                                           ' วินาทีของเสียง : ${e.soundDuration.toString()}',
    //                                           style: pw.TextStyle(font: ttf),
    //                                         )
    //                                       ],
    //                                     ),
    //                                     pw.TableRow(
    //                                       children: [
    //                                         pw.Text(
    //                                           ' สถานที่ : ${e.place.toString()}',
    //                                           style: pw.TextStyle(font: ttf),
    //                                         )
    //                                       ],
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                               // pw.Expanded(
    //                               //   child: pw.Column(
    //                               //       children: [pw.Text('Sheet 01')]),
    //                               // ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               )
    //               .toList(),
    //         ),
    //       );
    //     },
    //   ),
    // );

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
