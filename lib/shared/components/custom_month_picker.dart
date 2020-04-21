import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class CustomMonthPicker extends StatefulWidget {
  final int firstMonth;
  final int firstYear;
  final int lastMonth;
  final int lastYear;
  final int initialMonth;
  final int initialYear;
  final Function(int year, int month) onChange;
  final bool disabled;

  CustomMonthPicker(
      {@required this.onChange,
      @required this.firstMonth,
      @required this.firstYear,
      @required this.lastMonth,
      @required this.lastYear,
      @required this.initialMonth,
      @required this.initialYear,
      this.disabled = false});

  @override
  _CustomMonthPickerState createState() => _CustomMonthPickerState();
}

class _CustomMonthPickerState extends State<CustomMonthPicker> {
  List<String> _monthNames = DateHelper.monthsOfTheYear();
  int _month;
  int _year;

  @override
  Widget build(BuildContext context) {
    _month = _month ?? widget.initialMonth;
    _year = _year ?? widget.initialYear;
    return Row(
      children: <Widget>[
        Expanded(
          child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: 'Mês',
            ),
            isDense: true,
            items: _buildMonthItems(),
            onChanged: widget.disabled ? null : _onChangeMonth,
            value: widget.disabled ? null : _month,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: 'Ano',
              ),
              isDense: true,
              items: _buildYearItems(),
              onChanged: widget.disabled ? null : _onChangeYear,
              value: widget.disabled ? null : _year,
            ),
          ),
        ),
      ],
    );
  }

  void _onChangeYear(v) {
    setState(() {
      _year = v;
      widget.onChange(_year, _month);
    });
  }

  void _onChangeMonth(v) {
    setState(() {
      _month = v;
      widget.onChange(_year, _month);
    });
  }

  List<DropdownMenuItem<int>> _buildMonthItems() {
    int i = 1;
    var items = _monthNames.map<DropdownMenuItem<int>>((monthName) {
      return DropdownMenuItem<int>(
        child: Text(monthName),
        value: i++,
      );
    }).toList();
    return items;
  }

  List<DropdownMenuItem<int>> _buildYearItems() {
    List<int> years = List.generate(
        widget.lastYear - widget.firstYear, (i) => widget.firstYear + i);
    var items = years.map<DropdownMenuItem<int>>((year) {
      return DropdownMenuItem<int>(
        child: Text(year.toString()),
        value: year,
      );
    }).toList();
    return items;
  }
}
