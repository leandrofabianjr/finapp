import 'package:finapp/db/sqls.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final int version = 1;
  static final String dbName = 'finapp.db';

  static Future<Database> getDb() async {
    final String path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      onCreate: (db, version) {
        debugPrint('Creating database');
        _migrateDb(db, 0, version);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        debugPrint('Upgrading database');
        _migrateDb(db, oldVersion, newVersion);
      },
//      onDowngrade: (db, v1, v2) async {
//        debugPrint('Droping database: $v1 $v2');
//        db.query('sqlite_master').then((res) {
//          res.forEach((tbl) async {
//            debugPrint('drop table ${tbl['name']}');
//            await db.execute('drop table ${tbl['name']}');
//          });
//        });
//      },
      version: version,
    );
  }

  static _migrateDb(db, oldVersion, newVersion) {
    List<int>.generate(newVersion - oldVersion, (i) => oldVersion + i).forEach((version) {
      debugPrint('Executing database scripts to version $version');
      sqlVersions[version].forEach((query) async {
        debugPrint(query);
        await db.execute(query);
      });
    });
  }
}
