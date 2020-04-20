import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class CustomMonthPicker extends StatefulWidget {
  final int initialValue;
  final Function(int value) onChange;

  CustomMonthPicker({@required this.onChange, this.initialValue = 1});

  @override
  _CustomMonthPickerState createState() => _CustomMonthPickerState();
}

class _CustomMonthPickerState extends State<CustomMonthPicker> {
  List<String> _months = DateHelper.monthsOfTheYear();
  int value;
  
  @override
  Widget build(BuildContext context) {
    value = value ?? widget.initialValue;
    int i = 1;
    var items = _months.map<DropdownMenuItem<int>>((monthName) {
      return DropdownMenuItem<int>(
        child: Text(monthName),
        value: i++,
      );
    }).toList();
    return DropdownButton<int>(
      items: items,
      onChanged: (v) {
        setState(() {
          value = v;
          widget.onChange(v);
        });
      },
      value: value,
    );
  }
}
