import 'package:flutter/material.dart';

class SelectList<T> extends StatefulWidget {

  final Future<List<T>> data;
  final ListTile Function(BuildContext, T) listTileBuilder;

  SelectList({@required this.data, @required this.listTileBuilder});

  @override
  _SelectListState<T> createState() => _SelectListState<T>(this.data, this.listTileBuilder);
}

class _SelectListState<T> extends State<SelectList<T>> {

  final Future<List<T>> data;
  final ListTile Function(BuildContext, T) listTileBuilder;

  _SelectListState(this.data, this.listTileBuilder);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
            initialData: List(),
            future: data,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ],
                    ),
                  );
                  break;

                case ConnectionState.done:
                  final List<T> objList = snapshot.data;
                  var list = ListView.builder(
                    itemBuilder: (context, index) => listTileBuilder(context, objList[index]),
                    itemCount: objList != null ? objList.length : 0,
                  );
                  return list;
                  break;

                default:
                  return Text('Erro desconhecido');
              }
            }
    );
  }
}
