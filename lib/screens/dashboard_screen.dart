import 'package:finapp/models/movement.dart';
import 'package:finapp/screens/movement_list.dart';
import 'package:finapp/screens/movement_new_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FinApp')),
      body: ListView(children: <Widget>[
        FlatButton(
          child: Text('Ver movimentações'),
          onPressed: () {
             Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => MovementListScreen()));
          },
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push<Movement>(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MovementNewScreen()))
              .then((movement) => {print(movement.toString())})
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
