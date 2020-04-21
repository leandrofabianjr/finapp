import 'package:finapp/db/daos/dao.dart';
import 'package:finapp/models/movement.dart';
import 'package:finapp/screens/movement_list_filter_dialog.dart';
import 'package:finapp/shared/helpers/date_helper.dart';


class MovementDao extends Dao<Movement> {
  @override
  String tblName = 'movement';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colValue = 'value';
  String colDatetime = 'datetime';
  String colIdAccount = 'id_account';
  String colIdCategory = 'id_category';

  @override
  Map<String, dynamic> toRow(Movement obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colValue: obj.value,
      colDatetime: DateHelper.dateTimeToUnix(obj.datetime),
      colIdAccount: obj.idAccount,
      colIdCategory: obj.idCategory,
    };
  }

  @override
  Movement toObj(Map<String, dynamic> row) {
    return Movement(
      id: row[colId],
      name: row[colName],
      description: row[colDescription],
      value: row[colValue],
      datetime: DateHelper.unixToDateTime(row[colDatetime]),
      idAccount: row[colIdAccount],
      idCategory: row[colIdCategory],
    );
  }

  Future<List<Movement>> findAllOrderedByDate() {
    return findAll(orderBy: '$colDatetime DESC');
  }

  Future<List<Movement>> queryFromFilters(MovementFilters filters) {
    String where = '';
    List whereArgs = List();

    DateTime fromDate, toDate;
    if (filters.byPeriod) {
      fromDate = filters.fromDate;
      toDate = filters.toDate;
    } else {
      fromDate = DateTime(filters.year, filters.month, 1);
      toDate = DateTime(filters.year, filters.month + 1, 0);
    }

    where += '$colDatetime >= ? and $colDatetime <= ?';
    whereArgs.add(DateHelper.firstMomentOfTheDayUnix(fromDate));
    whereArgs.add(DateHelper.lastMomentOfTheDayUnix(toDate));

    return findAll(
      orderBy: '$colDatetime DESC',
      where: where,
      whereArgs: whereArgs,
    );
  }
}
