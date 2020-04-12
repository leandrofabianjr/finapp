import 'package:finapp/db/daos/category_type_dao.dart';
import 'package:finapp/models/category_type.dart';
import 'package:flutter/material.dart';

import 'category_type_new.dart';

class CategoryTypeSelect extends StatefulWidget {
  @override
  _CategoryTypeSelectState createState() => _CategoryTypeSelectState();
}

class _CategoryTypeSelectState extends State<CategoryTypeSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um tipo de categoria'),
      ),
      body: FutureBuilder<List<CategoryType>>(
          initialData: List(),
          future: CategoryTypeDao().findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text('Loading')
                    ],
                  ),
                );
                break;

              case ConnectionState.done:
                final List<CategoryType> categoryTypes = snapshot.data;
                var list = ListView.builder(
                  itemBuilder: (context, index) {
                    var categoryType = categoryTypes[index];
                    return ListTile(
                      title: Text(categoryType.name),
                      leading: Icon(Icons.local_offer),
                      subtitle: categoryType.description != null ? Text(categoryType.description) : null,
                      trailing: categoryType.createdAt != null ? Icon(Icons.edit) : null,
                      onTap: () {
                        Navigator.pop<CategoryType>(context, categoryType);
                      },
                    );
                  },
                  itemCount: categoryTypes.length,
                );
                return list;
                break;

              default:
                return Text('Erro desconhecido');
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => CategoryTypeNewScreen())
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
