import 'package:finapp/models/account_type.dart';

import 'dao.dart';

class AccountTypeDao extends Dao<AccountType> {
  @override
  String tblName = 'account_type';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';

  @override
  AccountType toObj(Map<String, dynamic> row) {
    return AccountType(
      id: row[colId],
      name: row[colName],
      description: row[colDescription],
    );
  }

  @override
  Map<String, dynamic> toRow(AccountType obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
    };
  }
}
