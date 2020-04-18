import 'package:finapp/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'db/db.dart';

void main() {
  runApp(FinApp());
  Db.getDb()
    .then((db) => debugPrint('Database working'))
    .catchError((err) => debugPrint('Database is not working: ${err.toString()}'));
}

class FinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pinkAccent
      ),
      home: DashboardScreen()
    );
  }
}
