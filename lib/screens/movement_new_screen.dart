import 'package:finapp/models/account.dart';
import 'package:finapp/models/category.dart';
import 'package:finapp/models/movement.dart';
import 'package:finapp/screens/account_select.dart';
import 'package:finapp/screens/category_select.dart';
import 'package:finapp/shared/forms/money_text_editing_controller.dart';
import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class MovementNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova movimentação")),
      body: MovementNewForm(),
    );
  }
}

class MovementNewForm extends StatefulWidget {
  @override
  _MovementNewFormState createState() => _MovementNewFormState();
}

class _MovementNewFormState extends State<MovementNewForm> {
  final _formKey = GlobalKey<FormState>();
  Movement _movement = Movement();
  var _txtFieldValueCtrl = MoneyTextEditingController();
  var _txtFieldCategoryCtrl = TextEditingController();
  var _txtFieldAccountCtrl = TextEditingController();
  var _txtFieldDateCtrl = TextEditingController();

  void dispose() {
    _txtFieldValueCtrl.dispose();
    _txtFieldCategoryCtrl.dispose();
    _txtFieldAccountCtrl.dispose();
    _txtFieldDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                  controller: _txtFieldValueCtrl,
                  decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value.isEmpty ? 'Qual é o valor da movimentação?' : null,
                  onSaved: (val) => _movement.value = double.parse(val)),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value.isEmpty ? 'Identifique a movimentação' : null,
                onSaved: (val) => _movement.name = val,
              ),
              TextFormField(
                controller: _txtFieldDateCtrl,
                decoration: const InputDecoration(labelText: 'Dia'),
                readOnly: true,
                onTap: () async {
                  final nowDateTime = DateTime.now();
                  final picked = await showDatePicker(
                      context: context,
                      initialDate: nowDateTime,
                      firstDate: DateTime(nowDateTime.year - 10),
                      lastDate: DateTime(nowDateTime.year + 10));
                  if (picked != null) {
                    setState(() {
                      _movement.datetime = picked;
                      _txtFieldDateCtrl.text =
                          DateHelper.formatDateWeek(picked);
                    });
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Conta',
                ),
                controller: _txtFieldAccountCtrl,
                readOnly: true,
                onTap: () {
                  Navigator.push<Account>(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AccountSelect())).then((cat) {
                    if (cat != null) {
                      _movement.idAccount = cat.id;
                      _txtFieldAccountCtrl.text = cat.name;
                    }
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                ),
                controller: _txtFieldCategoryCtrl,
                readOnly: true,
                onTap: () {
                  Navigator.push<Category>(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategorySelect())).then((cat) {
                    if (cat != null) {
                      _movement.idCategory = cat.id;
                      _txtFieldCategoryCtrl.text = cat.name;
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
                      Navigator.pop<Movement>(context, _movement);
                    }
                  },
                  child: Text('Salvar movimentação'),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
