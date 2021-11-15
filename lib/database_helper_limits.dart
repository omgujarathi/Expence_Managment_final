import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:expence_management/limits.dart';

class DatabaseHelper {

  static DatabaseHelper? _databaseHelper;    // Singleton DatabaseHelper
  static Database? _database;                // Singleton Database

  String limitTable = 'limit_table';
  String colId = 'id';
  String colCategory = 'category';
  String colDescription = 'description';
  String colLimitsAmt='limits_amount';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  DatabaseHelper() {

    _databaseHelper ??= DatabaseHelper._createInstance(); // This is executed only once, singleton object

  }
  // DatabaseHelper._privateConstuctor();
  // static final DatabaseHelper instance = DatabaseHelper._privateConstuctor();

  // Future<Database> get database async =>_database ??= await initializeDatabase();

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await initializeDatabase();
    return _database;
  }
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'expence_managementdb_limit.db';

    // Open/create the database at a given path
    var limitsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return limitsDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $limitTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCategory TEXT,$colDescription TEXT,$colLimitsAmt INTEGER)');
  }

  // Fetch Operation: Get all limit objects from database
  Future<List<Map<String, dynamic>>> getlimitMapList() async {
    Database? db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $limitTable order by $colPriority ASC');
    var result = await db!.query(limitTable, orderBy: '$colLimitsAmt DESC');
    return result;
  }

  // Insert Operation: Insert a limit object to database
  Future<int> insertlimit(limit limit) async {
    Database? db = await this.database;
    var result = await db!.insert(limitTable, limit.toMap());
    return result;
  }

  // Update Operation: Update a limit object and save it to database
  Future<int> updatelimit(limit limit) async {
    var db = await this.database;
    var result = await db!.update(limitTable, limit.toMap(), where: '$colId = ?', whereArgs: [limit.id]);
    return result;
  }

  // Delete Operation: Delete a limit object from database
  Future<int> deletelimit(int id) async {
    var db = await this.database;
    int result = await db!.rawDelete('DELETE FROM $limitTable WHERE $colId = $id');
    return result;
  }

  // Get number of limit objects in database
  Future<int?> getCount() async {
    Database? db = await this.database;
    List<Map<String, dynamic>> x = await db!.rawQuery('SELECT COUNT (*) from $limitTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'limit List' [ List<limit> ]
  Future<List<limit>> getlimitList() async {

    var limitMapList = await getlimitMapList(); // Get 'Map List' from database
    int count = limitMapList.length;         // Count the number of map entries in db table

    List<limit> limitList = <limit>[];
    // For loop to create a 'limit List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      limitList.add(limit.fromMapObject(limitMapList[i]));
    }

    return limitList;
  }
  Future<List<String>> getcatagoryList() async {

    var limitMapList = await getlimitMapList(); // Get 'Map List' from database
    int count = limitMapList.length;         // Count the number of map entries in db table

    List<limit> limitList = <limit>[];
    List<String> categoryList=<String>[];
    // For loop to create a 'limit List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      limitList.add(limit.fromMapObject(limitMapList[i]));
      categoryList.add(limitList[i].category);
    }

    return categoryList;
  }
  Future<int> getsum()async{
    var limitMapList = await getlimitMapList(); // Get 'Map List' from database
    int count = limitMapList.length;         // Count the number of map entries in db table

    int categoryList=0;
    // For loop to create a 'limit List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      categoryList+=(limit.fromMapObject(limitMapList[i])).limits_amount;
    }

    return categoryList;
  }
}





