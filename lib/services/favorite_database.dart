import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FavoriteDatabase {
  static final tableFavorite = 'favoriteFood';
  static final columnId = 'id';
  static final columnFoodId = 'foodId';

  static Database _database;
  static FavoriteDatabase _FavoriteDatabase;

  FavoriteDatabase._createInstance();
  factory FavoriteDatabase() {
    if (_FavoriteDatabase == null) {
      _FavoriteDatabase = FavoriteDatabase._createInstance();
    }
    return _FavoriteDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "favoriteFood.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableFavorite ( 
          $columnId integer primary key autoincrement, 
          $columnFoodId text not null     
          )
        ''');
      },
    );
    return database;
  }

  void addFavoriteFood(String foodId) async {
    var db = await this.database;
    Map<String, dynamic> row = {FavoriteDatabase.columnFoodId: foodId};
    var result = await db.insert(FavoriteDatabase.tableFavorite, row);
    print('result : $result');
  }

  getFavoriteFoods() async {
    List<String> foodsId = [];
    var db = await this.database;
    List<Map> result = await db.query(tableFavorite);
    result.forEach((row) {
      foodsId.add(row['foodId'].toString());
      //print("FOOD IDS: "+row['foodId'].toString());
    });
    return foodsId;
  }
}
