import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/models/category.dart';
import 'package:finapp/screens/category_new.dart';
import 'package:finapp/shared/components/select_list.dart';
import 'package:flutter/material.dart';

class CategorySelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione uma categoria'),
      ),
      body: SelectList<Category>(
          data: CategoryDao().findAll(),
          listTileBuilder: (context, obj) => ListTile(
                title: Text(obj.name),
                leading: Icon(Icons.local_offer, color: obj.color),
                subtitle:
                    obj.description != null ? Text(obj.description) : null,
                trailing: obj.createdAt != null ? Icon(Icons.edit) : null,
                onTap: () {
                  Navigator.pop<Category>(context, obj);
                },
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<Category>(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CategoryNewScreen()))
            .then((category) {
          if (category != null) {
            Navigator.pop<Category>(context, category);
          }
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
