import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  FileManager._privateConstructor();

  static final FileManager instance = FileManager._privateConstructor();
  static Directory? _directory;

  Future<Directory?> get fileManager async {
    if (_directory != null) return _directory;
    _directory = await getExternalStorageDirectory();
    return _directory;
  }

  Future<String> writeImageFiles(
      String projectId, File image, String detailId) async {
    Directory? directory = await instance.fileManager;
    final imagePath = '${directory!.path}/storyboard_images/$projectId';
    final imageDir = await Directory(imagePath).create(recursive: true);

    if (imageDir.path.isNotEmpty) {
      final File newImage = await image.copy('${imageDir.path}/$detailId.jpg');
      // var compressImage = File('$imagePath/$detailId.jpg')..writeAsBytesSync(img.en);
      if (newImage.path != '')
        return newImage.path;
      else
        return '';
    }
    return '';
  }
}
