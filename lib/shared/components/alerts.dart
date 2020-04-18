import 'package:flutter/material.dart';

class Alerts {
  static void success(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.thumb_up),
          ),
          Text(message)
        ])));
  }

  static void warning(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.warning),
          ),
          Text(message)
        ])));
  }
}
