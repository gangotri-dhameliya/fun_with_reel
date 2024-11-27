// ignore_for_file: depend_on_referenced_packages

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:reels_app/infrastructure/model/ringtone_data_model.dart';
import 'package:reels_app/infrastructure/model/wallpaper_data_model.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  ///Favorite Wallpaper
  static const table = 'favourite_wallpaper';
  static const itemIdNumber = 'item_id_number';
  static const category = 'category';
  static const image = 'image';
  static const thumbnail = 'thumbnail';
  static const premium = 'premium';
  static const like = 'like';


  ///Favorite ringtone
  static const ringtoneTable = 'favourite_ringtone';
  static const ringtoneItemIdNumber = 'ringtone_item_id_number';
  static const ringtoneImage = 'ringtone_image';
  static const ringtoneName = 'name';
  static const ringtone = 'ringtone';
  static const ringtonePremium = 'ringtone_premium';
  static const ringtoneLike = 'ringtone_like';

  static Database? _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $itemIdNumber INTEGER PRIMARY KEY,
            $category TEXT NOT NULL,
            $image TEXT NOT NULL,
            $thumbnail TEXT NOT NULL,
            $premium BOOLEAN NOT NULL,
            $like BOOLEAN NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $ringtoneTable (
            $ringtoneItemIdNumber INTEGER PRIMARY KEY,
            $ringtoneImage TEXT NOT NULL,
            $ringtoneName TEXT NOT NULL,
            $ringtone TEXT NOT NULL,
            $ringtonePremium BOOLEAN NOT NULL,
            $ringtoneLike BOOLEAN NOT NULL
          )
          ''');
  }

  tableIsEmpty() async {
    return Sqflite.firstIntValue(
        await _db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  ringtoneTableIsEmpty() async {
    return Sqflite.firstIntValue(
        await _db!.rawQuery('SELECT COUNT(*) FROM $ringtoneTable'));
  }

  void insertWallpaperFavourites(WallpaperDataModel favourites) async {
    await _db!.insert(
      table,
      WallpaperDataModel.toJson(favourites),
    );
  }

  void insertRingtoneFavourites(RingtoneDataModel favourites) async {
    await _db!.insert(
      ringtoneTable,
      RingtoneDataModel.toJson(favourites),
    );
  }

  Future<List<WallpaperDataModel>> getWallpaperFavouritesData() async {
    String query = "SELECT * FROM $table";
    List<Map<String, dynamic>> dataList = await _db!.rawQuery(query, null);

    List<WallpaperDataModel> sampleDataList = [];
    for(var data in dataList){
      sampleDataList.add(WallpaperDataModel.fromJson(data));
    }
    return sampleDataList;
  }

  Future<List<RingtoneDataModel>> getRingtoneFavouritesData() async {
    String query = "SELECT * FROM $ringtoneTable";
    List<Map<String, dynamic>> dataList = await _db!.rawQuery(query, null);

    List<RingtoneDataModel> sampleDataList = [];
    for(var data in dataList){
      sampleDataList.add(RingtoneDataModel.fromJson(data));
    }
    return sampleDataList;
  }


  Future<void> updateWallpaperFavourites(WallpaperDataModel favouriteDataModel) async {
    await _db!.update(
      table,
      WallpaperDataModel.toJson(favouriteDataModel),
      where: "$image = ?",
      whereArgs: [favouriteDataModel.image],
    );
  }

  Future<void> deleteWallpaperFavourites(WallpaperDataModel favouriteDataModel) async {
    await _db!.delete(
      table,
      where: "$image = ?",
      whereArgs: [favouriteDataModel.image],
    );
  }

  Future<void> updateRingtoneFavourites(RingtoneDataModel favouriteDataModel) async {
    await _db!.update(
      ringtoneTable,
      RingtoneDataModel.toJson(favouriteDataModel),
      where: "$ringtone = ?",
      whereArgs: [favouriteDataModel.ringtone],
    );
  }

  Future<void> deleteRingtoneFavourites(RingtoneDataModel favouriteDataModel) async {
    await _db!.delete(
      ringtoneTable,
      where: "$ringtone = ?",
      whereArgs: [favouriteDataModel.ringtone],
    );
  }

}
