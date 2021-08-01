import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:storyboard_camt/models/user.dart';

class PdfManager {
  static Future<File> generatePDF() async {
    final pdf = Document();

    final headers = ['iFirst', '31'];

    final users = [
      User(firstName: 'James', lastName: 'Bones'),
      User(firstName: 'Emma', lastName: 'Watson'),
    ];

    final data = users.map((user) => [user.firstName, user.lastName]).toList();

    pdf.addPage(Page(
      build: (context) => Table.fromTextArray(headers: headers, data: data),
    ));

    return saveDocument(name: 'test_pdf.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
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
