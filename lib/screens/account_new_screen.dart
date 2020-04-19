import 'package:finapp/db/daos/account_dao.dart';
import 'package:finapp/models/account.dart';
import 'package:finapp/models/account_type.dart';
import 'package:finapp/screens/account_type_select_screen.dart';
import 'package:finapp/shared/components/alerts.dart';
import 'package:flutter/material.dart';

class AccountNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova conta")),
      body: AccountNewForm(),
    );
  }
}

class AccountNewForm extends StatefulWidget {
  @override
  _AccountNewFormState createState() => _AccountNewFormState();
}

class _AccountNewFormState extends State<AccountNewForm> {
  final _formKey = GlobalKey<FormState>();
  Account _account = Account();
  TextEditingController _txtFieldAccountTypeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'A conta precisa de um nome';
                  }
                  return null;
                },
                onSaved: (val) => _account.name = val,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                ),
                onSaved: (val) => _account.description = val,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tipo da conta',
                ),
                controller: _txtFieldAccountTypeCtrl,
                readOnly: true,
                onTap: () {
                  Navigator.push<AccountType>(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AccountTypeSelectScreen())).then((accType) {
                    if (accType != null) {
                      _account.idAccountType = accType.id;
                      _txtFieldAccountTypeCtrl.text = accType.name;
                    }
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      AccountDao().insert(_account).then((obj) {
                        Navigator.pop<Account>(context, obj);
                      }).catchError((err) {
                        debugPrint('Erro ao salvar conta: ${err.toString()}');
                        Alerts.warning(
                            context, 'Desculpe, a conta não pode ser salva');
                      });
                    }
                  },
                  child: Text('Salvar conta'),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
