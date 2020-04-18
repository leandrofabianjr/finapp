import 'package:finapp/db/daos/account_type_dao.dart';
import 'package:finapp/models/account_type.dart';
import 'package:finapp/screens/account_type_new.dart';
import 'package:finapp/shared/components/select_list.dart';
import 'package:flutter/material.dart';

class AccountTypeSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um tipo de conta'),
      ),
      body: SelectList(
          data: AccountTypeDao().findAll(),
          listTileBuilder: (context, obj) => ListTile(
                title: Text(obj.name),
                subtitle:
                    obj.description != null ? Text(obj.description) : null,
                trailing: obj.createdAt != null ? Icon(Icons.edit) : null,
                onTap: () => Navigator.pop<AccountType>(context, obj),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<AccountType>(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AccountTypeNewScreen()))
            .then((accountType) {
          if (accountType != null) {
            Navigator.pop<AccountType>(context, accountType);
          }
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
