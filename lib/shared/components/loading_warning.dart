import 'package:flutter/material.dart';

class LoadingWarning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator(), Text('Carregando')],
      ),
    );
  }
}
