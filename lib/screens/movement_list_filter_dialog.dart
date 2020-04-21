import 'package:finapp/shared/components/custom_month_picker.dart';
import 'package:finapp/shared/components/date_period_picker.dart';
import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class MovementFilters {
  static final currentDate = DateHelper.currentDate;
  int month;
  int year;
  bool byPeriod;
  DateTime fromDate;
  DateTime toDate;

  MovementFilters()
      : this.month = currentDate.month,
        this.year = currentDate.year,
        this.byPeriod = false,
        this.fromDate = currentDate.subtract(Duration(days: 30)),
        this.toDate = currentDate;

  @override
  String toString() {
    return 'MovementFilters{month: $month, year: $year, byPeriod: $byPeriod, fromDate: $fromDate, toDate: $toDate}';
  }
}

class MovementListFilterDialog extends StatefulWidget {
  final MovementFilters filters;
  MovementListFilterDialog({this.filters});
  @override
  _MovementListFilterDialogState createState() =>
      _MovementListFilterDialogState();
}

class _MovementListFilterDialogState extends State<MovementListFilterDialog> {
  MovementFilters _filters;

  @override
  Widget build(BuildContext context) {
    _filters = _filters ?? widget.filters ?? MovementFilters();
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar movimentações'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, _filters);
            },
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Icon(Icons.today, color: Theme.of(context).accentColor),
              ),
              Text('Filtros de data',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.subhead.fontSize,
                    color: Theme.of(context).accentColor
                  )),
            ],
          ),
        ),
        ListTile(
          title: CustomMonthPicker(
            disabled: _filters.byPeriod,
            onChange: (year, month) {
              _filters.year = year;
              _filters.month = month;
            },
            firstMonth: 1,
            firstYear: MovementFilters.currentDate.year - 5,
            lastMonth: 12,
            lastYear: MovementFilters.currentDate.year + 5,
            initialMonth: MovementFilters.currentDate.month,
            initialYear: MovementFilters.currentDate.year,
          ),
        ),
        CheckboxListTile(
          title: Text('Filtrar por período'),
          value: _filters.byPeriod,
          onChanged: (val) => setState(() => _filters.byPeriod = val),
        ),
        ListTile(
          title: DatePeriodPicker(
            initialFromDate: _filters.fromDate,
            initialToDate: _filters.toDate,
            disabled: !_filters.byPeriod,
            onChange: (fromDate, toDate) {
              _filters.fromDate = fromDate;
              _filters.toDate = toDate;
            },
          ),
        ),
      ]),
    );
  }
}
