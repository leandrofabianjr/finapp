import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final int lastVersion = 1;
  static final String dbName = 'finapp.db';

  static Future<Database> getDb() async {
    final String path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      onCreate: (db, newVersion) async {
        debugPrint('Creating database');
        await _migrateDb(db, 0, newVersion);
      },
      onUpgrade: (db, currentVersion, newVersion) async {
        debugPrint('Upgrading database');
        await _migrateDb(db, currentVersion, newVersion);
      },
      version: lastVersion,
    );
  }

  static _migrateDb(Database db, currentVersion, newVersion) async {
    List<int> versionsToMigrate = List<int>.generate(
        newVersion - currentVersion, (i) => currentVersion + 1 + i);

    versionsToMigrate.forEach((version) async {
      String script =
          await rootBundle.loadString(join('assets', 'db', '$version.sql'));
      debugPrint('Executing database scripts to version $version');
      var queries = script.split(';');
      queries.forEach((q) async {
        String sql = q.trim();
        if (sql.isNotEmpty) {
          debugPrint(sql);
          await db.execute(sql);
          debugPrint('Query executed');
        }
      });
      debugPrint('Migration succeeded');
    });
  }

  static seed(Database db) async {
    String script =
        await rootBundle.loadString(join('assets', 'db', 'seeds.sql'));
    debugPrint('Executing database seeding scripts');
    var queries = script.split(';');
    queries.forEach((q) async {
      String sql = q.trim();
      if (sql.isNotEmpty) {
        debugPrint(sql);
        await db.execute(sql);
        debugPrint('Query executed');
      }
    });
    debugPrint('Seeding succeeded');
  }
}
