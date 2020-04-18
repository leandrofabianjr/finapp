import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:finapp/models/account.dart';

import 'dao.dart';

class AccountDao extends Dao<Account> {
  @override
  String tblName = 'account_type';
  @override
  String colPk = 'id';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colIdAccountType = 'id_account_type';
  String colCreatedAt = 'created_at';
  String colDeletedAt = 'deleted_at';

  @override
  Account toObj(Map<String, dynamic> row) {
    return Account(
      id: row[colId],
      name: row[colName],
      description: row[colDescription],
      idAccountType: row[colIdAccountType],
      createdAt: DateHelper.stringToDateTime(row[colCreatedAt]),
      deletedAt: DateHelper.stringToDateTime(row[colDeletedAt]),
    );
  }

  @override
  Map<String, dynamic> toRow(Account obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colIdAccountType: obj.idAccountType,
      colCreatedAt: obj.createdAt.toString(),
      colDeletedAt: obj.deletedAt.toString()
    };
  }
}
