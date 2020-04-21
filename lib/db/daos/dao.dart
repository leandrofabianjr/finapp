import 'package:finapp/db/db.dart';
import 'package:finapp/models/model.dart';
import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:sqflite/sqflite.dart';

abstract class Dao<T extends Model> {
  String tblName;

  String colCreatedAt = 'created_at';
  String colDeletedAt = 'deleted_at';

  Map<int, T> _mapCache;

  Map<String, dynamic> toRow(T obj);
  T toObj(Map<String, dynamic> row);

  Future<T> insert(T obj) async {
    obj.createdAt = DateTime.now();
    var db = await Db.getDb();
    Map<String, dynamic> contactMap = _toRow(obj);
    obj.id = await db.insert(tblName, contactMap);
    return obj;
  }

  Future<List<T>> findAll({String orderBy, String where, List<dynamic> whereArgs}) async {
    final Database db = await Db.getDb();
    final List<Map<String, dynamic>> result =
        await db.query(tblName, orderBy: orderBy, where: where, whereArgs: whereArgs);
    List<T> list = _toObjList(result);
    return list;
  }

  Future<Map<int, T>> findAllAsMap({bool cache = false, String orderBy}) async {
    if (cache && this._mapCache != null) {
      return this._mapCache;
    }
    List<T> list = await findAll(orderBy: orderBy);
    if (cache) {
      this._mapCache = Map();
      list.forEach((obj) => this._mapCache[obj.id] = obj);
    }
    return this._mapCache;
  }

  Future<T> findById(int pk) async {
    final Database db = await Db.getDb();
    final List<Map<String, dynamic>> result =
        await db.query(tblName, where: 'id = ?', whereArgs: [pk]);
    var cat = _toObj(result.first);
    return cat;
  }

  List<T> _toObjList(List<Map<String, dynamic>> result) {
    return result.map((row) => _toObj(row)).toList();
  }

  T _toObj(Map<String, dynamic> row) {
    T obj = toObj(row);
    obj.createdAt = DateHelper.unixToDateTime(row[colCreatedAt]);
    obj.deletedAt = DateHelper.unixToDateTime(row[colDeletedAt]);
    return obj;
  }

  Map<String, dynamic> _toRow(T obj) {
    Map<String, dynamic> row = toRow(obj);
    row[colCreatedAt] = DateHelper.dateTimeToUnix(obj.createdAt);
    row[colDeletedAt] = DateHelper.dateTimeToUnix(obj.deletedAt);
    return row;
  }
}
