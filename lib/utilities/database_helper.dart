import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storyboard_camt/models/story_detail.dart';
import 'package:storyboard_camt/models/storyboard.dart';
import 'package:storyboard_camt/utilities/file_manager.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static final _databaseName = 'storyboard.db';
  static final _databaseVersion = 1;

  static final storyboardTable = 'storyboard_tbl';

  // Store
  static final storyboardId = 'id';
  static final projectName = 'project_name';
  static final createDate = 'create_date';
  static final userIdFK = 'user_id';

  // Store storyboard detail list.
  static final sbDetailTable = 'storyboard_detail_table';
  static final sbDetailId = 'id';
  static final sbImagePath = 'image_path';
  static final sbDuration = 'duration';
  static final sbVdoName = 'vdo_name';
  static final sbDescription = 'description';
  static final sbSound = 'sound';
  static final sbSoundDuration = 'sound_duration';
  static final sbPlace = 'place';
  static final sbForeignKey = 'storyboard_id';

  // Store user info.
  static final userTable = 'user';
  static final userId = 'id';
  static final userName = 'firstname';
  static final userLastname = 'lastname';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // create storyboard table.
    await db.execute('''
      CREATE TABLE $storyboardTable (
        $storyboardId TEXT PRIMARY KEY,
        $projectName TEXT NOT NULL,
        $createDate TEXT NOT NULL,
        $userIdFK TEXT NOT NULL
      )
      ''');

    // create storyboard detail table.
    await db.execute('''
      CREATE TABLE $sbDetailTable (
        $sbDetailId INTEGER PRIMARY KEY,
        $sbImagePath TEXT NOT NULL,
        $sbDuration TEXT NOT NULL,
        $sbVdoName TEXT NOT NULL,
        $sbDescription TEXT NOT NULL,
        $sbSound TEXT NOT NULL,
        $sbSoundDuration TEXT NOT NULL,
        $sbPlace TEXT NOT NULL,
        $sbForeignKey TEXT NOT NULL
      )
      ''');

    // create user table.
    await db.execute('''
      CREATE TABLE $userTable (
        $userId TEXT PRIMARY KEY,
        $userName TEXT NOT NULL,
        $userLastname TEXT NOT NULL
      )
      ''');
  }

  Future<bool> insertStoryboard(
      StoryboardModel storyboardInfo, List<File?> images) async {
    var _isSuccess = false;
    String saveImage = '';
    Database? db = await instance.database;
    // insert storyboard table and got the id and use it as foreign key
    // for detail table.
    var uuid = Uuid().v1();
    var result = await db!
        .insert(storyboardTable, storyboardInfo.toMap()..addAll({'id': uuid}));
    for (var i = 0; i < storyboardInfo.storyList!.length; i++) {
      storyboardInfo.storyList![i].storyboardId = uuid;
      var storyDetailId =
          await db.insert(sbDetailTable, storyboardInfo.storyList![i].toMap());
      // At first check has an image or not?
      // then get id from story detail and write an image file to local storage.
      if (images[i] != null)
        saveImage = await FileManager.instance
            .writeImageFiles(uuid, images[i]!, storyDetailId.toString());
      // Got image path and update into story detail table.
      if (saveImage != '')
        await db.update(sbDetailTable, {sbImagePath: saveImage},
            where: '$sbDetailId = ?', whereArgs: [storyDetailId.toString()]);
    }

    if (result != 0) _isSuccess = true;

    return _isSuccess;
  }

  // copy images used to compare with new images.
  Future<bool> updateStoryboard(StoryboardModel storyboardInfo,
      List<File?> images, List<File?> copyImages) async {
    Database? db = (await instance.database);
    String savedImagePath = '';

    var updateStorytable = await db!.update(
        storyboardTable, storyboardInfo.toMap(),
        where: '$storyboardId = ?', whereArgs: [storyboardInfo.id]);

    for (int i = 0; i < storyboardInfo.storyList!.length; i++) {
      if (storyboardInfo.storyList![i].id != null) {
        // check image are changed or not?
        if (images[i] != copyImages[i]) {
          // delete image from current directory.
          final dir = Directory(images[i]!.path);
          dir.deleteSync(recursive: true);
          // then add new image and update to table.
          if (images[i] != null)
            savedImagePath = await FileManager.instance.writeImageFiles(
                storyboardInfo.id!, images[i]!, storyboardInfo.id.toString());
          // Got image path and update into story detail table.
          if (savedImagePath != '')
            storyboardInfo.storyList![i].imagePath = savedImagePath;
          // await db.update(sbDetailTable, {sbImagePath: saveImage},
          //     where: '$sbDetailId = ?',
          //     whereArgs: [storyboardInfo.id.toString()]);
        }

        try {
          var updateStoryList = await db.update(
              sbDetailTable, storyboardInfo.storyList![i].toMap(),
              where: '$sbDetailId = ?',
              whereArgs: [storyboardInfo.storyList![i].id]);
        } catch (e) {
          print(
              'update story list id ${storyboardInfo.storyList![i].id} -> $e');
        }
      } else {
        // update with no current image.
        try {
          storyboardInfo.storyList![i].storyboardId = storyboardInfo.id;
          var storyDetailId = await db.insert(
              sbDetailTable, storyboardInfo.storyList![i].toMap());
          // At first check has an image or not?
          // then get id from story detail and write an image file to local storage.
          if (images[i] != null)
            savedImagePath = await FileManager.instance.writeImageFiles(
                storyboardInfo.id!, images[i]!, storyDetailId.toString());
          // Got image path and update into story detail table.
          if (savedImagePath != '')
            await db.update(sbDetailTable, {sbImagePath: savedImagePath},
                where: '$sbDetailId = ?',
                whereArgs: [storyDetailId.toString()]);
        } catch (e) {
          print(
              'update story list id ${storyboardInfo.storyList![i].id} -> $e');
        }
      }
    }

    // storyboardInfo.storyList!.forEach((item) async {
    //   if (item.id != null) {
    //     try {
    //       var updateStoryList = await db.update(sbDetailTable, item.toMap(),
    //           where: '$sbDetailId = ?', whereArgs: [item.id]);
    //     } catch (e) {
    //       print('update story list id ${item.id} -> $e');
    //     }
    //   } else {
    //     try {
    //       // var updateStoryList = await db.update(sbDetailTable, item.toMap(),
    //       //     where: '$sbDetailId = ?', whereArgs: [item.id]);
    //       var storyDetailId = await db.insert(sbDetailTable, item.toMap());
    //       // At first check has an image or not?
    //       // then get id from story detail and write an image file to local storage.
    //       if (images[i] != null)
    //         saveImage = await FileManager.instance
    //             .writeImageFiles(uuid, images[i]!, storyDetailId.toString());
    //       // Got image path and update into story detail table.
    //       if (saveImage != '')
    //         await db.update(sbDetailTable, {sbImagePath: saveImage},
    //             where: '$sbDetailId = ?',
    //             whereArgs: [storyDetailId.toString()]);
    //     } catch (e) {
    //       print('update story list id ${item.id} -> $e');
    //     }
    //   }
    // });

    if (updateStorytable != 0)
      return true;
    else
      return false;
  }

  Future<List<StoryboardModel>> getStoryboardInfo(String userId) async {
    Database? db = (await instance.database);
    final List<Map<String, dynamic>> maps = await db!
        .query(storyboardTable, where: '$userIdFK = ?', whereArgs: [userId]);

    var storyboardProjects = List.generate(maps.length, (i) {
      print('get all storyboard id [$i] -> ${maps[i]['id']}');
      return StoryboardModel(
        id: maps[i]['id'].toString(),
        createDate: DateTime.parse(maps[i]['create_date']),
        author: maps[i]['author'],
        projectName: maps[i]['project_name'],
      );
    });

    return storyboardProjects;
  }

  Future<List<StoryDetail>> getStoryDetailById(String id) async {
    Database? db = (await instance.database);
    final List<Map<String, dynamic>> maps = await db!
        .query(sbDetailTable, where: '$sbForeignKey = ?', whereArgs: [id]);
    maps.forEach((element) {
      print('storyboard id -> ${element[sbForeignKey]}');
    });
    return List.generate(maps.length, (i) => StoryDetail.fromMap(maps[i]));
  }

  // Delete storyboard and story detail table by storyboard_id and foreign key.
  Future<void> deleteStoryboard(List<StoryboardModel> storyboardList) async {
    final db = await instance.database;
    storyboardList.forEach((element) async {
      await db!.delete(storyboardTable,
          where: '$storyboardId = ?', whereArgs: [element.id]);
      await db.delete(sbDetailTable,
          where: '$sbForeignKey = ?', whereArgs: [element.id]);
    });
  }
}
