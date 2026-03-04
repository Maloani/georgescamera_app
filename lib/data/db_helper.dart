// data/db_helper.dart
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      p.join(dbPath, 'endroits.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE endroits(
            id TEXT PRIMARY KEY,
            nom TEXT NOT NULL,
            imagePath TEXT,
            latitude REAL,
            longitude REAL,
            address TEXT,
            mapSnapshotPath TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertEndroit(Map<String, Object?> data) async {
    final db = await DBHelper.database();
    await db.insert(
      'endroits',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getEndroits() async {
    final db = await DBHelper.database();
    return db.query('endroits', orderBy: 'rowid DESC');
  }

  static Future<void> deleteEndroit(String id) async {
    final db = await DBHelper.database();
    await db.delete('endroits', where: 'id = ?', whereArgs: [id]);
  }
}
