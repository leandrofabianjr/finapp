import 'package:finapp/models/movement.dart';
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
                labelText: 'Nome da movimentação',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Identifique a movimentação';
                }
                return null;
              },
              onSaved: (val) => _movement.nome = val,
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
    );
  }
}
