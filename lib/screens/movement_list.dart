import 'package:finapp/db/daos/account_dao.dart';
import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/db/daos/movement_dao.dart';
import 'package:finapp/models/movement.dart';
import 'package:finapp/screens/movement_new_screen.dart';
import 'package:finapp/shared/helpers/date_helper.dart';
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
          return await MovementDao().findAllOrderedByDate();
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
              return ListView(children: _buidMovementsList(snapshot.data));
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

  List<Widget> _buidMovementsList(List<Movement> movements) {
    int day;
    int month;
    List<Widget> list = List();
    for (int i = 0; i < movements.length; i++) {
      final movement = movements[i];
      debugPrint(movement.toString());
      final category = _catDao.cache[movement.idCategory];
      if (day != movement.datetime.day || month != movement.datetime.month) {
        day = movement.datetime.day;
        month = movement.datetime.month;
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.title.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Text(DateHelper.getMonthName(movement.datetime).toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).primaryColor.withAlpha(100),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
      }
      list.add(Card(
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
                      fontSize: Theme.of(context).textTheme.subtitle.fontSize),
                ),
              ],
            ),
            title: Text(movement.name + ' ' + movement.datetime.day.toString()),
            subtitle: Row(children: <Widget>[
              Text(category.name),
            ])),
      ));
    }
    return list;
  }
}
