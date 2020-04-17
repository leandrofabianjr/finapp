import 'package:sqflite/sqflite.dart';

import '../db.dart';

abstract class Dao<T> {
  String tblName;
  String colPk;

  Map<String, dynamic> toRow(T obj);
  T toObj(Map<String, dynamic> row);

  Future<int> save(T obj) async {
    var db = await Db.getDb();
    Map<String, dynamic> contactMap = toRow(obj);
    return db.insert(tblName, contactMap);
  }

  Future<List<T>> findAll() async {
    final Database db = await Db.getDb();
    final List<Map<String, dynamic>> result = await db.query(tblName);
    List<T> list = _toObjList(result);
    return list;
  }

  Future<T> findById(int pk) async {
    final Database db = await Db.getDb();
    final List<Map<String, dynamic>> result = await db.query(tblName,
        where: '$colPk = ?',
        whereArgs: [pk]
    );
    var cat = toObj(result.first);
    return cat;
  }

  List<T> _toObjList(List<Map<String, dynamic>> result) {
    return result.map((row) => toObj(row)).toList();
  }
}