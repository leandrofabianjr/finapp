import 'package:finapp/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(FinApp());

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
