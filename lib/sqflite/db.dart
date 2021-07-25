import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import '../providers/models/resto.dart';

class DBSql {

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'mydatabase.db'), 
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
            CREATE TABLE resto(
              id INTEGER PRIMARY KEY,
              nom TEXT NOT NULL,
              type TEXT NOT NULL,
              ville TEXT NOT NULL,
              commune TEXT NOT NULL,
              tel TEXT NOT NULL,
              longi TEXT NOT NULL,
              lati TEXT NOT NULL,
              image TEXT NOT NULL
            ) 
          '''
        );
      }
    );
  }

  static Future<void> insert(String table, Resto resto) async {
    final db = await DBSql.database();
    db.insert(table, resto.tojson(), conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBSql.database();
    return db.query(table);
  }
}
