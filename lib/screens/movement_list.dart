import 'package:finapp/db/daos/account_dao.dart';
import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/db/daos/movement_dao.dart';
import 'package:finapp/models/movement.dart';
import 'package:finapp/screens/movement_new_screen.dart';
import 'package:flutter/material.dart';

class MovementListScreen extends StatefulWidget {
  @override
  _MovementListScreenState createState() => _MovementListScreenState();
}

class _MovementListScreenState extends State<MovementListScreen> {
  CategoryDao _catDao = CategoryDao();
  AccountDao _accDao = AccountDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimentações'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<List<Movement>>(
        future: () async {
          await _accDao.findAll(cache: true);
          await _catDao.findAll(cache: true);
          return await MovementDao().findAll();
        }(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Text('Não há movimentações')],
                ),
              );
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando')
                  ],
                ),
              );
              break;
            case ConnectionState.done:
              return _buidMovementsList(snapshot.data);
              break;
            default:
              return Text('Erro desconhecido');
          }
        },
      ),
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

  ListView _buidMovementsList(List<Movement> movements) {
    return ListView.builder(
      padding: EdgeInsets.all(4),
      itemCount: movements.length,
      itemBuilder: (context, i) {
        final movement = movements[i];
        final category = _catDao.cache[movement.idCategory];
        return Card(
          child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.local_offer, color: category.color),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'R\$ ' + movement.value.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.subtitle.fontSize),
                  ),
                ],
              ),
              title: Text(movement.name),
              subtitle: Row(children: <Widget>[
                Text(category.name),
              ])),
        );
      },
    );
  }
}
