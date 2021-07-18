import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storyboard_camt/models/story_detail.dart';
import 'package:storyboard_camt/models/storyboard.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static final _databaseName = 'storyboard.db';
  static final _databaseVersion = 1;

  static final storyboardTable = 'storyboard_tbl';

  // Store
  static final storyboardId = 'id';
  static final projectName = 'project_name';
  static final createDate = 'create_date';

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
        $createDate TEXT NOT NULL
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
        $userId INTEGER PRIMARY KEY,
        $userName TEXT NOT NULL,
        $userLastname TEXT NOT NULL
      )
      ''');
  }

  Future<bool> insertStoryboard(StoryboardModel storyboardInfo) async {
    var _isSuccess = false;
    Database? db = await instance.database;
    // insert storyboard table and got the id and use it as foreign key
    // for detail table.
    var uuid = Uuid().v1();
    var result = await db!
        .insert(storyboardTable, storyboardInfo.toMap()..addAll({'id': uuid}));
    storyboardInfo.storyList!.forEach((element) async {
      element.storyboardId = uuid;
      await db.insert(sbDetailTable, element.toMap());
    });

    if (result.isOdd) _isSuccess = true;

    return _isSuccess;
  }

  Future<List<StoryboardModel>> getStoryboardInfo() async {
    Database? db = (await instance.database);
    final List<Map<String, dynamic>> maps = await db!.query(storyboardTable);

    var storyboardProjects = List.generate(maps.length, (i) {
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
    final List<Map<String, dynamic>> maps = await db!.query(sbDetailTable);

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
