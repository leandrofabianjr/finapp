import 'package:finapp/db/daos/account_dao.dart';
import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/db/daos/movement_dao.dart';
import 'package:finapp/models/account.dart';
import 'package:finapp/models/category.dart';
import 'package:finapp/models/movement.dart';
import 'package:finapp/screens/movement_list_filter_dialog.dart';
import 'package:finapp/screens/movement_new_screen.dart';
import 'package:finapp/shared/components/loading_warning.dart';
import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class MovementListScreen extends StatefulWidget {
  final AccountDao _accDao = AccountDao();
  final CategoryDao _catDao = CategoryDao();

  @override
  _MovementListScreenState createState() => _MovementListScreenState();
}

class _MovementListScreenState extends State<MovementListScreen> {
  Map<int, Account> _allAccount;
  Map<int, Category> _allCategories;

  MovementFilters _filters = MovementFilters();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimentações'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push<MovementFilters>(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) =>
                      MovementListFilterDialog(filters: _filters),
                ),
              ).then((val) {
                if (val != null) {
                  setState(() => _filters = val);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Movement>>(
        initialData: List(),
        future: () async {
          _allAccount = await widget._accDao.findAllAsMap(cache: true);
          _allCategories = await widget._catDao.findAllAsMap(cache: true);
          return await MovementDao().queryFromFilters(_filters);
        }(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return EmptyListWarning();
              break;
            case ConnectionState.waiting:
              return LoadingWarning();
              break;
            case ConnectionState.done:
              if (snapshot.data.isEmpty) {
                return EmptyListWarning();
              }
              return _buildMovementsList(snapshot.data);
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

  Widget _buildMovementsList(List<Movement> movements) {
    int day;
    int month;
    List<Widget> list = List();
    for (int i = 0; i < movements.length; i++) {
      final movement = movements[i];
      if (day != movement.datetime.day || month != movement.datetime.month) {
        day = movement.datetime.day;
        month = movement.datetime.month;
        list.add(DayDivider(day: day, movement: movement));
      }
      list.add(
          MovementListTile(movement: movement, categories: _allCategories));
    }
    return ListView(children: list);
  }
}

class EmptyListWarning extends StatelessWidget {
  const EmptyListWarning({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text('Não há movimentações')],
      ),
    );
  }
}

class MovementListTile extends StatelessWidget {
  const MovementListTile({
    Key key,
    @required this.movement,
    @required this.categories,
  }) : super(key: key);

  final Movement movement;
  final Map<int, Category> categories;

  @override
  Widget build(BuildContext context) {
    final category = categories[movement.idCategory];
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
                    fontSize: Theme.of(context).textTheme.subtitle.fontSize),
              ),
            ],
          ),
          title: Text(movement.name),
          subtitle: Row(children: <Widget>[
            Text(category.name),
          ])),
    );
  }
}

class DayDivider extends StatelessWidget {
  final int day;
  final Movement movement;

  const DayDivider({
    Key key,
    @required this.day,
    @required this.movement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (DateHelper.isToday(movement.datetime)) {
      content = Text(
        'Hoje',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.subtitle.fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.title.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              DateHelper.getMonthName(movement.datetime).toUpperCase(),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.subtitle.fontSize,
                color: Theme.of(context).primaryColor.withAlpha(100),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8.0, right: 8, bottom: 8),
      child: content,
    );
  }
}
