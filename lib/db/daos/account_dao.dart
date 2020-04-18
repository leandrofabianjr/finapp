import 'package:finapp/models/account.dart';

import 'dao.dart';

class AccountDao extends Dao<Account> {
  @override
  String tblName = 'account';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colIdAccountType = 'id_account_type';

  @override
  Account toObj(Map<String, dynamic> row) {
    return Account(
      id: row[colId],
      name: row[colName],
      description: row[colDescription],
      idAccountType: row[colIdAccountType],
    );
  }

  @override
  Map<String, dynamic> toRow(Account obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colIdAccountType: obj.idAccountType,
    };
  }
}
