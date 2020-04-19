import 'package:finapp/db/daos/account_dao.dart';
import 'package:finapp/models/account.dart';
import 'package:finapp/screens/account_new_screen.dart';
import 'package:finapp/shared/components/select_list.dart';
import 'package:flutter/material.dart';

class AccountSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione uma conta'),
      ),
      body: SelectList<Account>(
          data: AccountDao().findAll(),
          listTileBuilder: (context, obj) => ListTile(
                title: Text(obj.name),
                subtitle:
                    obj.description != null ? Text(obj.description) : null,
                trailing: obj.createdAt != null ? Icon(Icons.edit) : null,
                onTap: () {
                  Navigator.pop<Account>(context, obj);
                },
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<Account>(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AccountNewScreen()))
            .then((category) {
          if (category != null) {
            Navigator.pop<Account>(context, category);
          }
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
