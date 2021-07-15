import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storyboard_camt/models/storyboard.dart';

class DatabaseHelper {
  static final _databaseName = 'storyboard.db';
  static final _databaseVersion = 1;

  static final storyboardTable = 'storyboard_tbl';

  // Store
  static final storyboardId = '_id';
  static final projectName = 'project_name';
  static final createDate = 'create_date';

  // Store storyboard detail list.
  static final sbDetailTable = 'storyboard_detail_table';
  static final sbDetailId = '_id';
  static final sbImagePath = 'sb_image_path';
  static final sbDuration = 'sb_duration';
  static final sbDescription = 'sb_description';
  static final sbSound = 'sb_sound';
  static final sbSoundDuration = 'sb_sound_duration';
  static final sbPlace = 'sb_place';

  // Store user info.
  static final userTable = 'user';
  static final userId = '_id';
  static final userName = 'user_name';
  static final userLastname = 'user_lastname';

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
        $storyboardId INTEGER PRIMARY KEY,
        $projectName TEXT NOT NULL,
        $createDate TEXT NOT NULL
      )
      ''');

    // create storyboard detail table.
    await db.execute('''
      CREATE TABLE $sbDetailTable (
        $sbDetailId INTEGER PRIMARY KEY,
        $sbImagePath TEXT NOT NULL;
        $sbDuration TEXT NOT NULL;
        $sbDescription TEXT NOT NULL;
        $sbSound TEXT NOT NULL;
        $sbSoundDuration TEXT NOT NULL;
        $sbPlace TEXT NOT NULL;
      )
      ''');

    // create user table.
    await db.execute('''
      CREATE TABLE $userTable (
        $userId INTEGER PRIMARY KEY,
        $userName TEXT NOT NULL,
        $userLastname TEXT NOT NULL;
      )
      ''');
  }

  Future<int?> insertStoryboard(StoryboardModel storyboardInfo) async {
    Database? db = await instance.database;

    storyboardInfo.storyList!.forEach((element) async {
      await db!.insert(sbDetailTable, element.toMap());
    });

    return await db!.insert(storyboardTable, storyboardInfo.toMap());
  }

  Future<List<StoryboardModel>> getStoryboardInfo() async {
    Database? db = (await instance.database);
    final List<Map<String, dynamic>> maps = await db!.query(storyboardTable);

    return List.generate(maps.length, (i) {
      return StoryboardModel(
        id: maps[i]['_id'],
        createDate: maps[i]['createDate'],
        author: maps[i]['author'],
        projectName: maps[i]['projectName'],
        storyList: maps[i]['storyList'],
      );
    });
  }
}
