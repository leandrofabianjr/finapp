import 'package:finapp/models/category_type.dart';
import 'package:flutter/material.dart';

class CategoryTypeNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo tipo de categoria")),
      body: CategoryTypeNewForm(),
    );
  }
}

class CategoryTypeNewForm extends StatefulWidget {
  @override
  _CategoryTypeNewFormState createState() => _CategoryTypeNewFormState();
}

class _CategoryTypeNewFormState extends State<CategoryTypeNewForm> {
  final _formKey = GlobalKey<FormState>();
  CategoryType _categoryType = CategoryType();

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
                  return 'O tipo de categoria precisa de um nome';
                }
                return null;
              },
              onSaved: (val) => _categoryType.name = val,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição (opcional)',
              ),
              onSaved: (val) => _categoryType.description = val,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.pop<CategoryType>(context, _categoryType);
                  }
                },
                child: Text('Salvar tipo de categoria'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
