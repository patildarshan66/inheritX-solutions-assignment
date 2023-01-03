import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteOperations extends GetxController {
  late Database db;

  Future<void> openDB(String tableName) async {
    try {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, 'my_db.db');

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $tableName (name TEXT PRIMARY KEY, currency TEXT, unicodeFlag TEXT, flag TEXT, dialCode TEXT)');
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String,dynamic>>> getEntries(String tableName) async {
    try{
      return db.query(tableName);
    }catch(e){
      rethrow;
    }
  }

  Future<void> addEntries(String tableName,List<Map<String,dynamic>> list) async {
    try{
       Batch batch = db.batch();

       for (var element in list) {
         batch.insert(tableName, element,conflictAlgorithm : ConflictAlgorithm.replace);
       }
       batch.commit().onError((error, stackTrace) {
         throw error.toString();
       });
    }catch(e){
      rethrow;
    }
  }

  Future<bool> deleteEntry(String tableName, String name) async {
    try {
      int count = await db.delete(tableName, where: 'name = ?', whereArgs: [name]);
      return count == 1;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> closeDB() async {
    await db.close();
  }
}
