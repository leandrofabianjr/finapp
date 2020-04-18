import 'package:finapp/models/movement.dart';
import 'package:finapp/shared/helpers/date_helper.dart';

import 'dao.dart';

class MovementDao extends Dao<Movement> {
  @override
  String tblName = 'movement';
  @override
  String colPk = 'id';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colValue = 'value';
  String colDatetime = 'datetime';
  String colIdAccount = 'id_account';
  String colIdCategory = 'id_category';
  String colCreatedAt = 'created_at';
  String colDeletedAt = 'deleted_at';

  @override
  Map<String, dynamic> toRow(Movement obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colValue: obj.value,
      colDatetime: DateHelper.dateTimeToString(obj.datetime),
      colIdAccount: obj.idAccount,
      colIdCategory: obj.idCategory,
      colCreatedAt: DateHelper.dateTimeToString(obj.createdAt),
      colDeletedAt: DateHelper.dateTimeToString(obj.deletedAt)
    };
  }

  @override
  Movement toObj(Map<String, dynamic> row) {
    return Movement(
        id: row[colId],
        name: row[colName],
        description: row[colDescription],
        value: row[colValue],
        datetime: row[colDatetime],
        idAccount: row[colIdAccount],
        idCategory: row[colIdCategory],
        createdAt: DateHelper.stringToDateTime(row[colCreatedAt]),
        deletedAt: DateHelper.stringToDateTime(row[colDeletedAt]));
  }
}
