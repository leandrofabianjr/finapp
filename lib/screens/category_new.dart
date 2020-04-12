import 'package:finapp/models/category.dart';
import 'package:finapp/models/category_type.dart';
import 'package:flutter/material.dart';

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
  var _txtFieldCategoryTypeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                Navigator
                    .push<CategoryType>(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => CategoryTypeSelect())
                ).then((catType) {
                  if (catType != null) {
                    _category.idCategoryType = catType.id;
                    _txtFieldCategoryTypeCtrl.text = catType.name;
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
                    Navigator.pop<Category>(context, _category);
                  }
                },
                child: Text('Salvar categoria'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
