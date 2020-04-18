import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/models/category.dart';
import 'package:finapp/models/category_type.dart';
import 'package:finapp/shared/components/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'category_type_select.dart';

class CategoryNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova categoria")),
      body: CategoryNewForm(),
    );
  }
}

class CategoryNewForm extends StatefulWidget {
  @override
  _CategoryNewFormState createState() => _CategoryNewFormState();
}

class _CategoryNewFormState extends State<CategoryNewForm> {
  final _formKey = GlobalKey<FormState>();
  Category _category = Category();
  TextEditingController _txtFieldCategoryTypeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _category.color = _category.color ?? Theme.of(context).accentColor;

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
                    return 'A categoria precisa de um nome';
                  }
                  return null;
                },
                onSaved: (val) => _category.name = val,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                ),
                onSaved: (val) => _category.description = val,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tipo da categoria',
                ),
                controller: _txtFieldCategoryTypeCtrl,
                readOnly: true,
                onTap: () {
                  Navigator.push<CategoryType>(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryTypeSelect())).then((catType) {
                    if (catType != null) {
                      _category.idCategoryType = catType.id;
                      _txtFieldCategoryTypeCtrl.text = catType.name;
                    }
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FlatButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Text('Selecione a cor da etiqueta',
                              textAlign: TextAlign.center),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: _category.color,
                              onColorChanged: (color) {
                                setState(() => _category.color = color);
                                Navigator.pop(ctx);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.local_offer,
                            size: 46, color: _category.color),
                        Expanded(
                            child: Text('Alterar a cor da etiqueta',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor))),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      CategoryDao().insert(_category).then((obj) {
                        Navigator.pop<Category>(context, obj);
                      }).catchError((err) {
                        debugPrint(
                            'Erro ao salvar categoria: ${err.toString()}');
                        Alerts.warning(context,
                            'Desculpe, a categoria não pode ser salva');
                      });
                    }
                  },
                  child: Text('Salvar categoria'),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
