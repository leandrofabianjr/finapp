import 'package:finapp/db/daos/account_dao.dart';
import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/db/daos/movement_dao.dart';
import 'package:finapp/models/category.dart';
import 'package:finapp/models/movement.dart';
import 'package:finapp/screens/movement_new_screen.dart';
import 'package:finapp/shared/components/custom_month_picker.dart';
import 'package:finapp/shared/components/date_period_picker.dart';
import 'package:finapp/shared/components/loading_warning.dart';
import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class MovementListScreen extends StatefulWidget {
  @override
  _MovementListScreenState createState() => _MovementListScreenState();
}

class _MovementListScreenState extends State<MovementListScreen> {
  CategoryDao _catDao = CategoryDao();
  AccountDao _accDao = AccountDao();
  bool _showingDatePickers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimentações'),
        actions: <Widget>[
          MaterialButton(
            child: Icon(Icons.date_range, color: Colors.white),
            color: _showingDatePickers
                ? Theme.of(context).accentColor.withAlpha(64)
                : null,
            onPressed: () {
              setState(() => _showingDatePickers = !_showingDatePickers);
            },
            shape: CircleBorder(),
            minWidth: kToolbarHeight,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          MovementsListFilter(
              showingDatePickers: _showingDatePickers, context: context),
          Expanded(
            child: FutureBuilder<List<Movement>>(
              initialData: List(),
              future: () async {
                await _accDao.findAll(cache: true);
                await _catDao.findAll(cache: true);
                return await MovementDao().findAllOrderedByDate();
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
          ),
        ],
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
      debugPrint(movement.toString());

      if (day != movement.datetime.day || month != movement.datetime.month) {
        day = movement.datetime.day;
        month = movement.datetime.month;
        list.add(DayDivider(day: day, movement: movement));
      }
      list.add(MovementListTile(movement: movement, categories: _catDao.cache));
    }
    return ListView(children: list);
  }
}

class MovementsListFilter extends StatelessWidget {
  const MovementsListFilter({
    Key key,
    @required this.showingDatePickers,
    @required this.context,
  }) : super(key: key);

  final bool showingDatePickers;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (showingDatePickers) {
      content = DatePeriodPicker(
        onChange: (DateTime fromDate, DateTime untilDate) {
          debugPrint(fromDate.toString());
          debugPrint(untilDate.toString());
        },
      );
    } else {
      int currentMonth = DateTime.now().month;
      int currentYear = DateTime.now().year;
      content = CustomMonthPicker(
        onChange: (year, month) {
          debugPrint(year.toString() + ' ' + month.toString());
        },
        firstMonth: 1,
        firstYear: currentYear - 5,
        lastMonth: 12,
        lastYear: currentYear + 5,
        initialMonth: currentMonth,
        initialYear: currentYear,
      );
    }

    return Container(
      width: double.infinity,
      height: 64,
      color: Theme.of(context).accentColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 4),
        child: content,
      ),
    );
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
          title: Text(movement.name + ' ' + movement.datetime.day.toString()),
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
