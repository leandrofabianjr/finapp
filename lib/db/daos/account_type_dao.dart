import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:finapp/models/account_type.dart';

import 'dao.dart';

class AccountTypeDao extends Dao<AccountType> {
  @override
  String tblName = 'account_type';
  @override
  String colPk = 'id';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colCreatedAt = 'created_at';
  String colDeletedAt = 'deleted_at';

  @override
  AccountType toObj(Map<String, dynamic> row) {
    return AccountType(
      id: row[colId],
      name: row[colName],
      description: row[colDescription],
      createdAt: DateHelper.stringToDateTime(row[colCreatedAt]),
      deletedAt: DateHelper.stringToDateTime(row[colDeletedAt]),
    );
  }

  @override
  Map<String, dynamic> toRow(AccountType obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colCreatedAt: obj.createdAt.toString(),
      colDeletedAt: obj.deletedAt.toString()
    };
  }
}
