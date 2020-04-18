import 'package:flutter/material.dart';

class MoneyTextEditingController extends TextEditingController {
  final int decimals;
  final String separator;

  MoneyTextEditingController(
      {this.separator = ',', this.decimals = 2, String text = '0,00'})
      : super(text: text) {
    this.addListener(() {
      final text = this.text.toLowerCase();
      String onlyNumbers = _removeAllExceptDigits(text);
      String noLeadingZeros = _removeLeadingZeros(onlyNumbers);
      String withPaddingZeros = noLeadingZeros.padLeft(this.decimals + 1, '0');
      String withCentsComma = _addDecimalSeparator(withPaddingZeros);
      // debugPrint('$text -> $onlyNumbers -> $noLeadingZeros -> $withCentsComma');
      this.value = this.value.copyWith(
            text: withCentsComma,
            selection: TextSelection(
                baseOffset: withCentsComma.length,
                extentOffset: withCentsComma.length),
            composing: TextRange.empty,
          );
    });
  }

  String _removeAllExceptDigits(String value) =>
      value.replaceAll(RegExp(r'[^\d]+'), '');

  String _removeLeadingZeros(String value) =>
      value.replaceFirst(RegExp(r'^0+(?!$)'), "");

  String _addDecimalSeparator(String value) =>
      value.substring(0, value.length - this.decimals) +
      this.separator +
      value.substring(value.length - this.decimals);

  get valueAsDouble {
    String strDouble = this.text.replaceAll(this.separator, '.');
    return double.parse(strDouble);
  }
}
