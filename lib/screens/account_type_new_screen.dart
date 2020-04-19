import 'package:finapp/db/daos/account_type_dao.dart';
import 'package:finapp/models/account_type.dart';
import 'package:finapp/shared/components/alerts.dart';
import 'package:flutter/material.dart';

class AccountTypeNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo tipo de conta")),
      body: AccountTypeNewForm(),
    );
  }
}

class AccountTypeNewForm extends StatefulWidget {
  @override
  _AccountTypeNewFormState createState() => _AccountTypeNewFormState();
}

class _AccountTypeNewFormState extends State<AccountTypeNewForm> {
  final _formKey = GlobalKey<FormState>();
  AccountType _accountType = AccountType();

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
                    return 'O tipo de conta precisa de um nome';
                  }
                  return null;
                },
                onSaved: (val) => _accountType.name = val,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                ),
                onSaved: (val) => _accountType.description = val,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  child: Text('Salvar tipo de conta'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      AccountTypeDao().insert(_accountType).then((obj) {
                        Navigator.pop<AccountType>(context, obj);
                      }).catchError((err) {
                        debugPrint(
                            'Erro ao salvar tipo de conta: ${err.toString()}');
                        Alerts.warning(context,
                            'Desculpe, o tipo de conta não pode ser salvo');
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
