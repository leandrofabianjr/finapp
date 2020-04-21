import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:flutter/material.dart';

class DatePeriodPicker extends StatefulWidget {
  final DateTime initialFromDate;
  final DateTime initialToDate;
  final void Function(DateTime fromDate, DateTime toDate) onChange;
  final bool disabled;

  DatePeriodPicker(
      {@required this.onChange,
      this.initialFromDate,
      this.initialToDate,
      this.disabled = false});

  @override
  _DatePeriodPickerState createState() => _DatePeriodPickerState();
}

class _DatePeriodPickerState extends State<DatePeriodPicker> {
  DateTime _fromDate;
  DateTime _toDate;
  var _fromDateCtrl = TextEditingController();
  var _toDateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nowDateTime = DateTime.now();
    _fromDate = _fromDate ?? widget.initialFromDate ?? nowDateTime;
    _toDate = _toDate ?? widget.initialToDate ?? nowDateTime;
    _fromDateCtrl.text = widget.disabled ? '' : DateHelper.formatDate(_fromDate);
    _toDateCtrl.text = widget.disabled ? '' : DateHelper.formatDate(_toDate);

    return Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Expanded(
        flex: 1,
        child: TextField(
          enabled: !widget.disabled,
          decoration: InputDecoration(
            labelText: 'De',
          ),
          controller: _fromDateCtrl,
          readOnly: true,
          onTap: () async {
            final val = await showDatePicker(
              context: context,
              initialDate: _fromDate,
              firstDate: DateTime(nowDateTime.year - 10),
              lastDate: _toDate,
            );
            if (val != null) {
              setState(() {
                _fromDate = val;
                _fromDateCtrl.text = DateHelper.formatDate(val);
                widget.onChange(_fromDate, _toDate);
              });
            }
          },
        ),
      ),
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextFormField(
            enabled: !widget.disabled,
            decoration: InputDecoration(
              labelText: 'Até',
            ),
            controller: _toDateCtrl,
            readOnly: true,
            onTap: () async {
              final val = await showDatePicker(
                context: context,
                initialDate: _toDate,
                firstDate: _fromDate,
                lastDate: DateTime(nowDateTime.year + 10),
              );
              if (val != null) {
                setState(() {
                  _toDate = val;
                  _toDateCtrl.text = DateHelper.formatDate(val);
                  widget.onChange(_fromDate, _toDate);
                });
              }
            },
          ),
        ),
      ),
    ]);
  }
}
